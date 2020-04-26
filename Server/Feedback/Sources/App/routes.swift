import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    let gameController = GameController()
    app.get("games", use: gameController.all)
    app.get("games",":gameID", use: gameController.getByID)
    app.post("games", use: gameController.create)
    app.delete("games", ":gameID", use: gameController.delete)
    
    let featureSuggestionController = FeatureSuggestionController()
    app.get("suggestions", use: featureSuggestionController.all)
    app.get("suggestions",":suggestionID", use: featureSuggestionController.getByID)
//    app.get("suggestions","by-game",":gameID", use: featureSuggestionController.getAllByGameID)
    app.post("suggestions", use: featureSuggestionController.create)
    app.delete("suggestions", ":suggestionID", use: featureSuggestionController.delete)
    
    let feedbackController = FeedbackController()
    app.get("feedback", use: feedbackController.all)
    app.get("feedback",":feedbackID", use: feedbackController.getByID)
    app.post("feedback", use: feedbackController.create)
    app.delete("feedback", ":feedbackID", use: feedbackController.delete)
}
