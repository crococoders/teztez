import Fluent
import FluentPostgresDriver
import Vapor


public func configure(_ app: Application) throws {
    app.databases.use(.postgres(
        hostname: Environment.get("POSTGRES_HOST")!,
        username: Environment.get("POSTGRES_USERNAME")!,
        password: Environment.get("POSTGRES_PASSWORD")!,
        database: Environment.get("POSTGRES_DB")!
    ), as: .psql)

    app.migrations.add(CreateGame())
    app.migrations.add(CreateFeatureSuggestion())
    app.migrations.add(CreateFeedback())

    try app.autoMigrate().wait()
    
    // register routes
    try routes(app)
}