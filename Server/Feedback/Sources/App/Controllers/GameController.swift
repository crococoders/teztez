import Fluent
import Vapor

struct GameController {
    func all(req: Request) throws -> EventLoopFuture<[Game]> {
        return Game.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Game> {
        let game = try req.content.decode(Game.self)
        return game.save(on: req.db).map { game }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Game.find(req.parameters.get("gameId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
