import Fluent
import Vapor

final class Article: Model, Content {
    static let schema = "articles"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "text")
    var text: String
    
    @Field(key: "image_url")
    var imageUrl: String?

    init() { }

    init(id: UUID? = nil, title: String, text: String, imageUrl: String? = nil) {
        self.id = id
        self.title = title
        self.text = text
        self.imageUrl = imageUrl
    }
}
