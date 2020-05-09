import Foundation

public enum GameType: String, Codable, CaseIterable {
    case personalCoach = "personal_coach"
    case backwards
    case blender
    case colorMatching = "color_matching"
    case schulteTable = "schulte_table"
    
    var clientReadable: String{
        switch self {
        case .personalCoach:
            return "Personal Coach"
        case .backwards:
            return "Backwards"
        case .blender:
            return "Blender"
        case .colorMatching:
            return "Color Matching"
        case .schulteTable:
            return "Schulte Table"
        }
    }
}
