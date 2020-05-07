import Fluent

struct CreateEvent: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Event.schema)
            .id()
            .field("user_id", .string, .required)
            .field("event_type", .string, .required)
            .field("game_type", .string, .required)
            .field("value", .int)
            .field("created_at", .datetime)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Event.schema).delete()
    }
}
