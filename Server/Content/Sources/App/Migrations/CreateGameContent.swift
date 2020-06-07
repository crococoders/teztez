import Fluent

struct CreateGameContent: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(GameContent.schema)
            .id()
            .field("title", .string, .required)
            .field("text", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(GameContent.schema).delete()
    }
}
