//
//  File.swift
//  
//
//  Created by Temirkhan Sailau on 5/8/20.
//

import Foundation
import Vapor
import Models

class RandomElementProvider<E> {
    private let array: [E]

    init(array: [E]) {
        self.array = array
    }

    func getRandom() -> E {
        return array.randomElement()!
    }
}

class RandomStatiticsProvider {
    let userId: String
    
    init(userId:String) {
        self.userId = userId
    }
    
    func getRandomStats(request: Request) throws -> EventLoopFuture<UserStatsPayload>{
        let firstRandomGameType = RandomElementProvider<GameType>(array: GameType.allCases).getRandom()
        var secondRandomGameType = RandomElementProvider<GameType>(array: GameType.allCases).getRandom()
        while (firstRandomGameType == secondRandomGameType) {
            secondRandomGameType = RandomElementProvider<GameType>(array: GameType.allCases).getRandom()
        }
        
        let firstRandomGameStatsFutures = try getGameStats(gameType: firstRandomGameType, request: request)
        let secondRandomGameStatsFutures = try getGameStats(gameType: secondRandomGameType, request: request)
        
        return request.eventLoop.flatten(firstRandomGameStatsFutures + secondRandomGameStatsFutures).map{
            gameStats in
            
            let userStats = [
                UserStat(gameType: firstRandomGameType, gameStats: Array(gameStats[0..<4])),
                UserStat(gameType: secondRandomGameType, gameStats: Array(gameStats[4...]))
            ]
            return UserStatsPayload(userId: self.userId, userStats: userStats)
        }
    }
    
    func getGameStats(gameType: GameType, request: Request) throws -> [EventLoopFuture<GameStat>] {
        var gameStatsFutures:[EventLoopFuture<GameStat>] = []
        
        for _ in 0..<4{
            let randomEventStatArgs = getRandomEventStatArgs(gameType: gameType)
            let gameStatFuture = try getGameStat(eventStatArgs: randomEventStatArgs, request: request)
            
            gameStatsFutures.append(gameStatFuture)
        }
        
        return gameStatsFutures
    }
    
    func getRandomEventStatArgs(gameType: GameType) -> EventStatArgs {
        
        let eventType = RandomElementProvider<EventType>(array: EventType.getEventTypes(for: gameType)).getRandom()
        let valueType = RandomElementProvider<ValueType>(array: eventType.valueTypes).getRandom()
        let dateFilter = RandomElementProvider<DateFilter>(array: DateFilter.allCases).getRandom()
        
        return EventStatArgs(userId: userId, gameType: gameType, eventType: eventType, dateFilter: dateFilter, valueType: valueType)
    }
    
    func getGameStat(eventStatArgs: EventStatArgs, request: Request) throws -> EventLoopFuture<GameStat> {
           
           let futureEvents = Event.query(on: request.db)
               .filter(\.$userId, .equal, userId)
               .filter(\.$gameType,.equal, eventStatArgs.gameType)
               .filter(\.$eventType, .equal, eventStatArgs.eventType)
               .group{ queryBuilder in
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
                   let total = events.reduce(0) { (result, event) -> Int in
                           return result + (event.value ?? 1)
                       }
                    if total == 0 {
                        return total 
                    }
                    else {
                        return total / events.count
                    }
                   
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
}
