import Fluent

struct CreateArticle: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("articles")
            .id()
            .field("title", .string, .required)
            .field("text", .string, .required)
            .field("image_url", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("articles").delete()
    }
}
