import Fluent
import Vapor
import Models

enum DateFilter:String,Codable,CaseIterable{
    case forToday = "for_today"
    case forLastWeek = "for_last_week"
    case forLastMonth = "for_last_month"
    case overall
    
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
    var valueType: ValueType
}


struct GameStat: Content{
    var eventType: EventType
    var dateFilter: DateFilter
    var valueType: ValueType
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

struct CreateEventsBody: Content{
    var events: [Event]
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
        let eventRoutes = routes.grouped("analytics")
        eventRoutes.get(Parameter.userId.queryParameter, use: getStats)
        eventRoutes.post(use: create)
        eventRoutes.delete(Parameter.eventId.queryParameter,use: delete)
    }
    
    func getStats(request: Request) throws -> EventLoopFuture<UserStatsPayload> {
        guard let userId = request.parameters.get(Parameter.userId.rawValue)
        else {throw Abort(.internalServerError)}
        
        let randomStatisticsProvider = RandomStatiticsProvider(userId: userId)
        
        return try randomStatisticsProvider.getRandomStats(request: request)
    }

    func create(request: Request) throws -> EventLoopFuture<[Event]> {
        let body = try request.content.decode(CreateEventsBody.self)
        let eventsFuture = body.events.map{event in event.save(on: request.db).map { event }}
        return request.eventLoop.flatten(eventsFuture)
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Event.find(request.parameters.get(Parameter.eventId.rawValue), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
