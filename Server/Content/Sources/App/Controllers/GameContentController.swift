import Fluent
import Vapor

struct GameContentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let gameContentRoutes = routes.grouped("content")
        gameContentRoutes.get(use: getAll)
        gameContentRoutes.get("next", use: getNextText)
        
        gameContentRoutes.post(use: create)
        gameContentRoutes.delete(":contentId", use: delete)
    }
    
    func getAll(request: Request) throws -> EventLoopFuture<[GameContent]> {
        return GameContent.query(on: request.db).all()
    }
    
    func getNextText(request: Request) throws -> EventLoopFuture<GameContent> {
        let gameContent = GameContent.query(on: request.db).count().flatMap{
            count in
           return GameContent.query(on: request.db)
            .offset(Int.random(in: 0..<count))
            .first()
            .unwrap(or: Abort(.notFound))
        }
        
        return gameContent
    }

    func create(request: Request) throws -> EventLoopFuture<GameContent> {
        let text = try request.content.decode(GameContent.self)
        return text.save(on: request.db).map { text }
    }

    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return GameContent.find(request.parameters.get("contentId"), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
