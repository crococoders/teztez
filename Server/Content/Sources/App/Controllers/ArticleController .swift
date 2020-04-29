import Fluent
import Vapor

struct ArticleController {
    func getAll(request: Request) throws -> EventLoopFuture<[Article]> {
        return Article.query(on: request.db).all()
    }
    
    func getByID(request: Request) throws -> EventLoopFuture<Article> {
        return Article.find(request.parameters.get("articleId"), on: request.db)
        .unwrap(or: Abort(.notFound))
    }

    func create(request: Request) throws -> EventLoopFuture<Article> {
        let article = try request.content.decode(Article.self)
        return article.save(on: request.db).map { article }
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Article.find(request.parameters.get("articleId"), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
