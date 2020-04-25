import Fluent
import Vapor

struct TextController {
    func all(req: Request) throws -> EventLoopFuture<[Text]> {
        return Text.query(on: req.db).all()
    }
    
    func getById(req: Request) throws -> EventLoopFuture<Text> {
        return Text.find(req.parameters.get("textID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func create(req: Request) throws -> EventLoopFuture<Text> {
        let text = try req.content.decode(Text.self)
        let words = text.text.split(separator: " ")
        let backwardWords = words.map{String($0.reversed())}
        text.backwardText = backwardWords.joined(separator:" ")
        
        return text.save(on: req.db).map { text }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Text.find(req.parameters.get("textID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
