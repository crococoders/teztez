import Fluent
import Vapor

struct ArticleController {
    func all(req: Request) throws -> EventLoopFuture<[Article]> {
        return Article.query(on: req.db).all()
    }
    
    func getByID(req: Request) throws -> EventLoopFuture<[Article]> {
        return Article.find(req.parameters.get("articleID"), on: req.db)
        .unwrap(or: Abort(.notFound))
    }

    func create(req: Request) throws -> EventLoopFuture<Article> {
        let article = try req.content.decode(Article.self)
        return article.save(on: req.db).map { article }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Article.find(req.parameters.get("articleID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
