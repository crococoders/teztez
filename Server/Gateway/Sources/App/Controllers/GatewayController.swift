//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 4/19/20.
//

import Vapor

final class GatewayController: RouteCollection {
    
    private let services: [ServiceNode] = [.init(path: "content", host: "CONTENT_HOST"),
                                           .init(path: "feedback", host: "FEEDBACK_HOST")]
    
    func boot(routes: RoutesBuilder) throws {
        for entry in services {
            routes.grouped(entry.path).use(handler: redirect)
        }
    }
    
    func handle(_ request: Request) throws -> String {
        return "Welcome to \(request.url.path)!"
    }
    
//    func redirect(_ request: Request, to service: ServiceNode) throws -> EventLoopFuture<ClientResponse> {
//        guard let serviceHost = service.host else {
//            throw Abort(.badRequest)
//        }
//        return try redirect(request, host: serviceHost)
//    }

    func redirect(_ request: Request) throws -> EventLoopFuture<ClientResponse> {
        guard let host = Environment.get("FEEDBACK_HOST") else {
            throw Abort(.internalServerError)
        }
        
        let client = request.client
        let uri = URI(string: host + request.url.string)
        var headers = request.headers
        headers.replaceOrAdd(name: .host, value: host)
        let request = ClientRequest(method: request.method, url: uri, headers: headers, body: request.body.data)
        return client.send(request)
    }
}
