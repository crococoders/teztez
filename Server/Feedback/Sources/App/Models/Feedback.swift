import Fluent
import Vapor

final class Feedback: Model, Content {
    static let schema = "feedbacks"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "text")
    var text: String
    
    @Field(key: "rate_score")
    var rateScore: Int
    
    @Parent(key: "game_id")
    var game: Game

    init() { }

    init(id: UUID? = nil, title: String, text: String,rateScore: Int, gameId: UUID) {
        self.id = id
        self.title = title
        self.text = text
        self.rateScore = rateScore
        self.$game.id = gameId
    }
}
