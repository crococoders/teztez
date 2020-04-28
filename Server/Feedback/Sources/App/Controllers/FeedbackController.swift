import Fluent
import Vapor

struct FeedbackController {
    func all(req: Request) throws -> EventLoopFuture<[Feedback]> {
        return Feedback.query(on: req.db).all()
    }

    func getAllFeedbacksByGameId(req: Request) throws -> EventLoopFuture<[Feedback]>{
        return Game.find(req.parameters.get("gameId"),on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{game in
                return Feedback.query(on: req.db).filter("game_id", .equal, game.id!).all()
        }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Feedback> {
        let feedback = try req.content.decode(Feedback.self)
        return feedback.save(on: req.db).map { feedback }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Feedback.find(req.parameters.get("feedbackId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
