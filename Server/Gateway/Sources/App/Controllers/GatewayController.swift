//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 4/19/20.
//

import Vapor

final class GatewayController: RouteCollection {
    
    private let microservices: [MicroserviceEntry] = [.init(path: "content", host: "CONTENT_HOST"),
                                                      .init(path: "feedback", host: "FEEDBACK_HOST")]
    
    func boot(routes: RoutesBuilder) throws {
        for entry in microservices {
            routes.grouped(entry.path).use(handler: handle)
        }
    }
    
    func handle(_ req: Request) throws -> String {
        return "Welcome to \(req.url.path)!"
    }
    
    func redirect(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        if req.url.string.contains("test") {
            guard let usersHost = Environment.get("TEST_HOST") else { throw Abort(.badRequest) }
            return try handle(req, host: usersHost)
        }
        throw Abort(.badRequest)
    }

    func handle(_ req: Request, host: String) throws -> EventLoopFuture<ClientResponse> {
        let client = req.client
        let uri = URI(string: host + req.url.string)
        var headers = req.headers
        headers.replaceOrAdd(name: .host, value: host)
        let request = ClientRequest(method: req.method, url: uri, headers: headers, body: req.body.data)
        return client.send(request)
    }
}
