//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 4/19/20.
//

import Vapor

extension HTTPMethod {
    public static var redirectableMethods: [HTTPMethod] {
        return [GET, PUT, POST, DELETE]
    }
}

extension RoutesBuilder {
    func use<Response: ResponseEncodable>(handler: @escaping (Request) throws -> Response) {
        HTTPMethod.redirectableMethods.forEach {
            on($0, "*", use: handler)
        }
    }
}

final class GatewayController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.grouped("test").use(handler: handle)
    }
    
    func handle(_ req: Request) throws -> String {
        return "Hello, world!"
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
        headers.replaceOrAdd(name: "host", value: host)
        let request = ClientRequest(method: req.method, url: uri, headers: headers, body: req.body.data)
        return client.send(request)
    }
}
