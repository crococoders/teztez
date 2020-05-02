import Fluent
import Vapor

func configureRoutes(for app: Application) throws {
    let feedbackController = FeedbackController()
    try app.register(collection: feedbackController)
}
