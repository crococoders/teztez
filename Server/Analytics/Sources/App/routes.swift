import Fluent
import Vapor

func configureRoutes(for app: Application) throws {
    let eventController = EventController()
    try app.register(collection: eventController)
}
