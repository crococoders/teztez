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
    
    @Field(key: "short_description")
    var shortDescription: String?
    
    @Field(key: "type")
    var type: String
    
    @Field(key: "image_url")
    var imageUrl: String?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }

    init(id: UUID? = nil, title: String, text: String, type: String, shortDescription: String? = nil, imageUrl: String? = nil) {
        self.id = id
        self.title = title
        self.text = text
        self.type = type
        self.shortDescription = shortDescription
        self.imageUrl = imageUrl
    }
}
