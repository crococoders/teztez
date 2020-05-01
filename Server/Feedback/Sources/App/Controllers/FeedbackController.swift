import Fluent
import Vapor

struct FeedbackController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let feedbackRoutes = routes.grouped("feedback")
        feedbackRoutes.get(use: getAll)
        feedbackRoutes.get("game",":gameTitle", use: getAllFeedbacksByGameTitle)
        feedbackRoutes.post(use: create)
        feedbackRoutes.delete(":feedbackId", use: delete)
    }
    
    func getAll(request: Request) throws -> EventLoopFuture<[Feedback]> {
        return Feedback.query(on: request.db).all()
    }

    func getAllFeedbacksByGameTitle(request: Request) throws -> EventLoopFuture<[Feedback]>{
        return Feedback.query(on: request.db).filter("game_title", .equal, request.parameters.get(":gameTitle")).all()
        
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
