import Fluent

struct CreateArticle: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Article.schema)
            .id()
            .field("title", .string, .required)
            .field("text", .string, .required)
            .field("type", .string, .required)
            .field("short_description", .string)
            .field("created_at", .datetime)
            .field("image_url", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Article.schema).delete()
    }
}
