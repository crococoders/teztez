import Fluent
import Vapor
import Models

final class Event: Model, Content {
    static let schema = "events"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "user_id")
    var userId: String
    
    @Field(key: "game_type")
    var gameType: GameType

    @Field(key: "event_type")
    var eventType: EventType
    
    @Field(key: "value")
    var value: Int?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }

    init(id: UUID? = nil, userId: String, gameType: GameType, eventType: EventType, value: Int? = nil, createdAt: Date? = nil) {
        self.id = id
        self.userId = userId
        self.gameType = gameType
        self.eventType = eventType
        self.value = value
        self.createdAt = createdAt
    }
}
