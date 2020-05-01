import Fluent
import Vapor

func configureRoutes(_ app: Application) throws {
    
    let feedbackController = FeedbackController()
     try app.register(collection: feedbackController)
}
