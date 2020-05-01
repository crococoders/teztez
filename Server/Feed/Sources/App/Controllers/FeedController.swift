//
//  FeedController.swift
//  App
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Vapor

final class FeedController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("feed")
        group.get("s", use: get)
    }
    
    private func get(request: Request) -> String {
        return ""
    }
}
