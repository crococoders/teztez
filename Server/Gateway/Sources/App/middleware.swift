//
//  middleware.swift
//  
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

func configureMiddleware(for app: Application) throws {
    let errorMiddleware = ErrorMiddleware.default(environment: app.environment)
    app.middleware.use(errorMiddleware)
}
