import Fluent
import Vapor

final class GameContent: Model, Content {
    static let schema = "game_contents"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "text")
    var text: String

    init() { }

    init(id: UUID? = nil, title: String, text: String) {
        self.id = id
        self.title = title
        self.text = text
    }
}
