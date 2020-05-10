//
//  File.swift
//  
//
//  Created by Temirkhan Sailau on 5/9/20.
//

import Vapor
import Models

struct GameStat: Content {
    var eventType: EventType
    var dateFilter: DateFilter
    var valueType: ValueType
    var value: Int
}

struct UserStat: Content {
    var gameType: GameType
    var gameStats: [GameStat]
}

struct UserStatsPayload: Content {
    var userId: String
    var userStats: [UserStat]
}
