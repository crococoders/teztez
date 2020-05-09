import Foundation

public enum EventType: String, Codable {
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
    
    public static func getEventTypes(for gameType: GameType) -> [EventType] {
        switch gameType{
        case .personalCoach:
            return [.gamePlayed,
                    .secondsSpentInGame,
                    .wpmSpeedChosen,
                    .numberOfWordsRead]
        case .backwards, .blender:
            return [.gamePlayed,
                    .secondsSpentInGame,
                    .numberOfWordsRead]
        case .colorMatching:
            return [.secondsSpentInGame,
                    .matchedBlocksCount,
                    .missedBlocksCount,
                    .gamePlayed]
        case .schulteTable:
            return [.gamePlayed,
                    .secondsSpentInGame,
                    .numbersEncountered,
                    .numbersMissed,
                    .numbersGuessedCorrectly,
                    .streakOfGuessedNumbers]
        }
    }
    
    public var valueTypes: [ValueType]{
        switch self {
        case .gamePlayed, .numberOfWordsRead, .numbersEncountered:
            return [.total]
        case .secondsSpentInGame, .matchedBlocksCount, .numbersGuessedCorrectly:
            return [.total, .average, .maximum]
        case .missedBlocksCount, .numbersMissed:
            return [.total, .average, .maximum, .minimum]
        case .streakOfGuessedNumbers, .wpmSpeedChosen:
            return [.average, .maximum]
        }
    }
    
    public func getStatTitleAndSubtitle(valueType: ValueType, dateFilter: DateFilter, gameType: GameType) -> (String, String) {
        switch self {
        case .secondsSpentInGame:
            return ("Minutes", "\(valueType) spent in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        case .wpmSpeedChosen:
            return ("WPM", "\(valueType) chosen in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        case .numberOfWordsRead:
            return ("Words", "\(valueType) read in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        case .gamePlayed:
            return ("Games", "\(gameType.clientReadable) played \(valueType) \(dateFilter.clientReadable)")
        case .matchedBlocksCount:
            return ("Blocks", "\(valueType) matched in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        case .missedBlocksCount:
            return ("Blocks", "\(valueType) missed in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        case .numbersEncountered:
            return ("Numbers encountered", "\(valueType) in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        case .numbersGuessedCorrectly:
            return ("Numbers", "\(valueType) guessed correctly in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        case .numbersMissed:
            return ("Numbers", "\(valueType) missed in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        case .streakOfGuessedNumbers:
            return ("Streak", "\(valueType) of guessed numbers in \(gameType.clientReadable) \(dateFilter.clientReadable)")
        }
    }
}
