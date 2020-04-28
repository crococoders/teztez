import Fluent
import Vapor

struct GameContentController {
    func all(req: Request) throws -> EventLoopFuture<[GameContent]> {
        return GameContent.query(on: req.db).all()
    }
    
    func nextText(req: Request) throws -> EventLoopFuture<GameContent> {
        let gameContent = GameContent.query(on: req.db).count().flatMap{
            count in
           return GameContent.query(on: req.db)
            .offset(Int.random(in: 0..<count))
            .first()
            .unwrap(or: Abort(.notFound))
        }
        
        return gameContent
    }

    func create(req: Request) throws -> EventLoopFuture<GameContent> {
        let text = try req.content.decode(GameContent.self)
        return text.save(on: req.db).map { text }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return GameContent.find(req.parameters.get("contentId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
