//
//  routes.swift
//
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

func configureRoutes(for app: Application) throws {
    let authController = AuthController()
    try app.register(collection: authController)
    
    let gatewayController = GatewayController()
    try app.register(collection: gatewayController)
}
