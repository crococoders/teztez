import Fluent
import Vapor

struct ArticleController: RouteCollection {
    private enum Parameter: String {
        case articleId

        var queryParameter: PathComponent {
            return .init(stringLiteral: ":\(rawValue)")
        }
    }

    func boot(routes: RoutesBuilder) throws {
        let articleRoutes = routes.grouped("articles")
        articleRoutes.get(use: getAll)
        articleRoutes.post(use: create)
        articleRoutes.delete(Parameter.articleId.queryParameter, use: delete)
    }

    func getAll(request: Request) throws -> EventLoopFuture<[Article]> {
        return Article.query(on: request.db).sort(\.$createdAt, .descending).all()
    }

    func create(request: Request) throws -> EventLoopFuture<Article> {
        let article = try request.content.decode(Article.self)
        return article.save(on: request.db).map { article }
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Article.find(request.parameters.get(Parameter.articleId.rawValue), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
