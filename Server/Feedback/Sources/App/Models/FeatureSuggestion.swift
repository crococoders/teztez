import Fluent
import Vapor

final class FeatureSuggestion: Model, Content {
    static let schema = "feature_suggestions"
    
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
