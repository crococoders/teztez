import Fluent
import Vapor

struct FeatureSuggestionController {
    func all(req: Request) throws -> EventLoopFuture<[FeatureSuggestion]> {
        return FeatureSuggestion.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<FeatureSuggestion> {
        let featureSuggestion = try req.content.decode(FeatureSuggestion.self)
        return featureSuggestion.save(on: req.db).map { featureSuggestion }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return FeatureSuggestion.find(req.parameters.get("suggestionId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
