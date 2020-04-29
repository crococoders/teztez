import Fluent
import Vapor

struct FeatureSuggestionController {
    func getAll(request: Request) throws -> EventLoopFuture<[FeatureSuggestion]> {
        return FeatureSuggestion.query(on: request.db).all()
    }

    func create(request: Request) throws -> EventLoopFuture<FeatureSuggestion> {
        let featureSuggestion = try request.content.decode(FeatureSuggestion.self)
        return featureSuggestion.save(on: request.db).map { featureSuggestion }
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return FeatureSuggestion.find(request.parameters.get("suggestionId"), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
