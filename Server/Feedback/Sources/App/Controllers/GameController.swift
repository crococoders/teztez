import Fluent
import Vapor

struct GameController {
    func all(request: Request) throws -> EventLoopFuture<[Game]> {
        return Game.query(on: request.db).all()
    }

    func create(request: Request) throws -> EventLoopFuture<Game> {
        let game = try request.content.decode(Game.self)
        return game.save(on: request.db).map { game }
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Game.find(req.parameters.get("gameId"), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
