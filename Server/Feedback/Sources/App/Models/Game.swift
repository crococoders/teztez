import Fluent
import Vapor

final class Game: Model, Content {
    static let schema = "games"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
//    @Children(for: \.$game)
//    var feedbacks: [Feedback]

    init() { }

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
