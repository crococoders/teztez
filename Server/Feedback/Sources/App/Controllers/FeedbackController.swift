import Fluent
import Vapor

struct FeedbackController {
    func all(req: Request) throws -> EventLoopFuture<[Feedback]> {
        return Feedback.query(on: req.db).all()
    }
    
    func getByID(req: Request) throws -> EventLoopFuture<Feedback> {
        return Feedback.find(req.parameters.get("feedbackId"), on: req.db)
        .unwrap(or: Abort(.notFound))
    }
    
//    func getAllByGameID(req: Request) throws -> EventLoopFuture<[Feedback]> {
//        return Feedback.query(on: req.db).filter(\.gameID == req.parameters.get("gameID"))
//    }

    func create(req: Request) throws -> EventLoopFuture<Feedback> {
        let feedback = try req.content.decode(Feedback.self)
        return feedback.save(on: req.db).map { feedback }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Feedback.find(req.parameters.get("feedbackID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
