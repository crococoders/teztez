//
//  RoutesBuilder+Use.swift
//  
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

extension RoutesBuilder {
    func use<Response: ResponseEncodable>(handler: @escaping (Request, Service) throws -> Response, service: Service) {
        HTTPMethod.redirectableMethods.forEach {
            on($0, .constant("")) {
                return try handler($0, service)
            }
            on($0, .anything) {
                return try handler($0, service)
            }
        }
    }
}
