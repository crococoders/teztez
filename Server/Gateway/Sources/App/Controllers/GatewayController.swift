//
//  File.swift
//
//
//  Created by Aidar Nugmanov on 4/19/20.
//

import Vapor

final class GatewayController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        for service in Service.allCases {
            routes.grouped(service.path).use(handler: redirect, service: service)
        }
    }

    func redirect(_ request: Request, to service: Service) throws -> EventLoopFuture<ClientResponse> {
        guard let host = service.host, let port = service.port else {
            throw Abort(.internalServerError)
        }
        let client = request.client
        let url = URI(string: "http://\(host):\(port)\(request.url.string)")
        request.logger.info("url is: \(url.description)")
        var headers = request.headers
        headers.replaceOrAdd(name: .host, value: host)
        let request = ClientRequest(method: request.method, url: url, headers: headers, body: request.body.data)
        return client.send(request)
    }
}
