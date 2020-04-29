import Fluent

struct CreateFeatureSuggestion: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(FeatureSuggestion.schema)
            .id()
            .field("title", .string, .required)
            .field("text", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(FeatureSuggestion.schema).delete()
    }
}
