//
//  RoutesBuilder+Use.swift
//  
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

extension RoutesBuilder {
    func use<Response: ResponseEncodable>(handler: @escaping (Request) throws -> Response) {
        HTTPMethod.redirectableMethods.forEach {
            on($0, PathComponent(stringLiteral: ""), use: handler)
            on($0, PathComponent.anything, use: handler)
        }
    }
}
