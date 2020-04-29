import Fluent
import Vapor

struct FeedbackController {
    func getAll(request: Request) throws -> EventLoopFuture<[Feedback]> {
        return Feedback.query(on: request.db).all()
    }

    func getAllFeedbacksByGameId(request: Request) throws -> EventLoopFuture<[Feedback]>{
        return Game.find(request.parameters.get("gameId"),on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{game in
                return Feedback.query(on: request.db).filter("game_id", .equal, game.id!).all()
        }
    }
    
    func create(request: Request) throws -> EventLoopFuture<Feedback> {
        let feedback = try request.content.decode(Feedback.self)
        return feedback.save(on: request.db).map { feedback }
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Feedback.find(request.parameters.get("feedbackId"), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
