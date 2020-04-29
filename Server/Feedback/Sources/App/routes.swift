import Fluent
import Vapor

func routes(_ app: Application) throws {
    let gameController = GameController()
    app.get("games", use: gameController.all)
    app.post("games", use: gameController.create)
    app.delete("games", ":gameId", use: gameController.delete)
    
    let featureSuggestionController = FeatureSuggestionController()
    app.get("suggestions", use: featureSuggestionController.getAll)
    app.post("suggestions", use: featureSuggestionController.create)
    app.delete("suggestions", ":suggestionId", use: featureSuggestionController.delete)
    
    let feedbackController = FeedbackController()
    app.get("feedback", use: feedbackController.getAll)
    app.get("feedback","game",":gameId", use: feedbackController.getAllFeedbacksByGameId)
    app.post("feedback", use: feedbackController.create)
    app.delete("feedback", ":feedbackId", use: feedbackController.delete)
}
