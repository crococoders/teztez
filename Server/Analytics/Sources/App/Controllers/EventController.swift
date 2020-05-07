import Fluent
import Vapor
import Models

enum StatValueType:String,Codable{
    case total, average, maximum, minimum
}

enum DateFilter:String,Codable{
    case forToday = "for_today",
    forLastWeek = "for_last_week",
    forLastMonth = "for_last_month",
    overall
    
    var dateThreshold: Date?{
        switch self {
        case .forToday:
            return Calendar.current.date(byAdding: .day, value: -1, to: Date())
        case .forLastWeek:
            return Calendar.current.date(byAdding: .day, value: -7, to: Date())
        case .forLastMonth:
            return Calendar.current.date(byAdding: .month, value: -1, to: Date())
        case .overall:
            return nil
        }
    }
}

struct EventStatArgs: Content{
    var userId: String
    var gameType: GameType
    var eventType: EventType
    var dateFilter: DateFilter
    var valueType: StatValueType
}


struct GameStat: Content{
    var eventType: EventType
    var dateFilter: DateFilter
    var valueType: StatValueType
    var value: Int
}

struct UserStat: Content{
    var gameType: GameType
    var gameStats: [GameStat]
}

struct UserStatsPayload: Content{
    var userId: String
    var userStats: [UserStat]
}


struct EventController: RouteCollection {
    private enum Parameter: String {
        case userId
        case eventId

        var queryParameter: PathComponent {
            return .init(stringLiteral: ":\(rawValue)")
        }
    }

    func boot(routes: RoutesBuilder) throws {
        let eventRoutes = routes.grouped("events")
        eventRoutes.get(Parameter.userId.queryParameter, use: getAllUserStats)
        eventRoutes.post(use: create)
        eventRoutes.delete(Parameter.eventId.queryParameter,use: delete)
    }
    
    
    
    func getAllUserStats(request: Request) throws -> EventLoopFuture<UserStatsPayload> {
        let userId = request.parameters.get(Parameter.userId.rawValue)!
        
        let personalCoachStats = try getPersonalCoachStats(userId:userId, request: request)
            .flatMapThrowing{ gameStats in
                UserStat(gameType: GameType.personalCoach, gameStats: gameStats)
        }
        
        return request.eventLoop.flatten([
            personalCoachStats
        ])
            .map{userStats in
            UserStatsPayload(userId: userId, userStats: userStats)}
    }
    
    
    func getPersonalCoachStats(userId: String, request: Request) throws -> EventLoopFuture<[GameStat]> {

        let totalGames = try getGameStat(eventStatArgs:
            EventStatArgs(userId: userId, gameType: GameType.personalCoach, eventType: EventType.gamePlayed, dateFilter: DateFilter.overall, valueType: StatValueType.total)
        , request: request)
        
        return request.eventLoop.flatten([totalGames])
    }
    
    func getGameStat(eventStatArgs: EventStatArgs, request: Request) throws -> EventLoopFuture<GameStat> {
        
        let futureEvents = Event.query(on: request.db)
            .filter(\.$userId, .equal, eventStatArgs.userId)
            .filter(\.$gameType,.equal, eventStatArgs.gameType)
            .filter(\.$eventType, .equal, eventStatArgs.eventType)
            .group{queryBuilder in
                if let dateThreshold = eventStatArgs.dateFilter.dateThreshold{
                    queryBuilder.filter(\.$createdAt, .greaterThanOrEqual, dateThreshold)
                }
            }
            .all()
        
        return futureEvents.map{ events in
            switch eventStatArgs.valueType{
            case .total:
                return events.reduce(0) { (result, event) -> Int in
                        return result + (event.value ?? 1)
                    }
            case .average:
                return events.reduce(0) { (result, event) -> Int in
                        return result + (event.value ?? 1)
                    } / events.count
            case .minimum:
                return events.sorted{
                        ($0.value ?? 1) > ($1.value ?? 1)
                    }.last?.value ?? 0
            case .maximum:
                return events.sorted{
                        ($0.value ?? 1) > ($1.value ?? 1)
                    }.first?.value ?? 0
            }
        }.map{ value in
            GameStat(eventType: eventStatArgs.eventType,
                     dateFilter: eventStatArgs.dateFilter,
                     valueType: eventStatArgs.valueType,
            value: value)}
    }

    func create(request: Request) throws -> EventLoopFuture<Event> {
        let event = try request.content.decode(Event.self)
        return event.save(on: request.db).map { event }
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Event.find(request.parameters.get(Parameter.eventId.rawValue), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
