import Fluent
import Vapor

final class Text: Model, Content {
    static let schema = "texts"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "text")
    var text: String
    
    @Field(key: "backward_text")
    var backwardText: String?

    init() { }

    init(id: UUID? = nil, title: String, text: String, backwardText: String? = nil) {
        self.id = id
        self.title = title
        self.text = text
        self.backwardText = backwardText
    }
}
