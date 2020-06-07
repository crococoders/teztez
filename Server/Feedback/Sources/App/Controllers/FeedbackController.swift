import Fluent
import Vapor

private enum FeedbackParameter: String, Codable {
    case gameTitle
    case feedbackId
    
    var queryParameter: PathComponent {
        return .init(stringLiteral: ":\(self.rawValue)")
    }
}

struct FeedbackController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let feedbackRoutes = routes.grouped("feedback")
        feedbackRoutes.get(use: getAll)
        feedbackRoutes.get("game", FeedbackParameter.gameTitle.queryParameter, use: getAllFeedbacksByGameTitle)
        feedbackRoutes.post(use: create)
        feedbackRoutes.delete(FeedbackParameter.gameTitle.queryParameter, use: delete)
    }
    
    func getAll(request: Request) throws -> EventLoopFuture<[Feedback]> {
        return Feedback.query(on: request.db).all()
    }

    func getAllFeedbacksByGameTitle(request: Request) throws -> EventLoopFuture<[Feedback]> {
        return Feedback.query(on: request.db).filter(\.$gameTitle, .equal, request.parameters.get(FeedbackParameter.gameTitle.rawValue)).all()
    }
    
    func create(request: Request) throws -> EventLoopFuture<EventLoopFuture<Feedback>> {
        let feedback = try request.content.decode(Feedback.self)
        
        guard let notificationServiceHost = Environment.get("NOTIFICATION_SERVICE_HOST"),
            let notificationServicePort = Environment.get("NOTIFICATION_SERVICE_PORT")
            else {throw Abort(.internalServerError)}
        
        let client = request.client
        let url = URI(string: "https://api.telegram.org/bot\("1086050988:AAFZddTtah0y-QJRRSSs_beqz1BtH6er1GU")/sendMessage?chat_id=\("-1001375011133")&text=\(feedback.text)")
        request.logger.info("url is: \(url.description)")
        var headers = request.headers
        headers.replaceOrAdd(name: .host, value: notificationServiceHost)
        let clientRequest = ClientRequest(method: request.method, url: url, headers: headers, body: request.body.data)
        
        return client.send(clientRequest).flatMapThrowing{ _ in
            return feedback.save(on: request.db).map {feedback}
        }
    }
    
    func delete(request: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Feedback.find(request.parameters.get(FeedbackParameter.feedbackId.rawValue), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: request.db) }
            .transform(to: .ok)
    }
}
