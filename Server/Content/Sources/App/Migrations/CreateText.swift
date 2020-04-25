import Fluent

struct CreateText: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("texts")
            .id()
            .field("title", .string, .required)
            .field("text", .string, .required)
            .field("backward_text", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("texts").delete()
    }
}
