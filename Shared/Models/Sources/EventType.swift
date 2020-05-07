import Foundation

public enum EventType: String, Codable {
    case secondsSpentInGame = "seconds_spent_in_game"
    case wpmSpeedChosen = "wpm_speed_chosen"
    case numberOfWordRead = "number_of_words_read"
    case gamePlayed = "game_played"
    case matchedBlocksCount = "matched_blocks_count"
    case totalNumberOfEncounters = "total_number_of_encounters"
    case numbersGuessedCorrectly = "numbers_guessed_correctly"
    case numbersMissed = "numbers_missed"
    case streakOfGuessedNumbers = "streak_of_guessed_numbers"
}
