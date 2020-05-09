//
//  AnalyticsEvent.swift
//  Teztez
//
//  Created by Adlet on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct AnalyticsEvent: Codable {
    enum GameType: String {
        case personalCoach = "personal_coach"
        case backwards
        case blender
        case colorMatching = "color_matching"
        case schulteTable = "schulte_table"
    }

    enum EventType: String {
        case secondsSpentInGame = "seconds_spent_in_game"
        case wpmSpeedChosen = "wpm_speed_chosen"
        case numberOfWordsRead = "number_of_words_read"
        case gamePlayed = "game_played"
        case matchedBlocksCount = "matched_blocks_count"
        case missedBlocksCount = "missed_blocks_count"
        case numbersEncountered = "numbers_encountered"
        case numbersGuessedCorrectly = "numbers_guessed_correctly"
        case numbersMissed = "numbers_missed"
        case streakOfGuessedNumbers = "streak_of_guessed_numbers"
    }

    let gameType: String
    let userId: String
    let eventType: String
    let value: Int

    init(gameType: GameType, eventType: EventType, value: Int) {
        self.gameType = gameType.rawValue
        self.eventType = eventType.rawValue
        self.value = value
        userId = UserSession.shared.userId ?? ""
    }
}
