//
//  RoutesBuilder+Use.swift
//  
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

extension RoutesBuilder {
    func use<Response: ResponseEncodable>(handler: @escaping (Request, Service) throws -> Response, service: Service) {
        for method in HTTPMethod.redirectableMethods {
            on(method, .constant("")) { request -> Response in
                let _ = try request.auth.require(User.self)
                return try handler(request, service)
            }
            on(method, .anything) { request -> Response in
                let _ = try request.auth.require(User.self)
                return try handler(request, service)
            }
        }
    }
}
