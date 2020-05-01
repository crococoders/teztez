import Vapor

func routes(_ app: Application) throws {
    let feedController = FeedController()
    try app.register(collection: feedController)
}
