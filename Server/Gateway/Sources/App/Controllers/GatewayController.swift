//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 4/19/20.
//

import Vapor

final class GatewayController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("test", "get", use: handle)
        routes.post(PathComponent.constant("test/post"), use: handle)
    }
    
    func handle(_ req: Request) throws -> EventLoopFuture<ClientResponse> {
        // TODO: Improve path checking
        if req.url.string.contains("test") {
//            guard let usersHost = Environment.get("TEST_HOST") else { throw Abort(.badRequest) }
            let usersHost = "http://localhost:8081"
            return try handle(req, host: usersHost)
        }
        throw Abort(.badRequest)
    }

    func handle(_ req: Request, host: String) throws -> EventLoopFuture<ClientResponse> {
        let client = req.client
        let uri = URI(string: host + req.url.string)
        var headers = req.headers
        headers.replaceOrAdd(name: "host", value: host)
        let request = ClientRequest(method: req.method, url: uri, headers: headers, body: req.body.data)
        return client.send(request)
    }
}
