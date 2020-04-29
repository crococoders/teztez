import Fluent

struct CreateFeedback: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Feedback.schema)
            .id()
            .field("title", .string, .required)
            .field("text", .string, .required)
            .field("rate_score", .int, .required)
            .field("game_id", .uuid, .references("games", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Feedback.schema).delete()
    }
}
