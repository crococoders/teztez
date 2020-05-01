import Fluent
import Vapor

public func configure(_ app: Application) throws {

    try configureDatabase(for: app)
    try configureMigrations(for: app)
    try configureRoutes(for: app)
}
