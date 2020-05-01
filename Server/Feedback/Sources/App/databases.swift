//
//  File.swift
//  
//
//  Created by Temirkhan Sailau on 4/30/20.
//

import Vapor
import Fluent
import FluentPostgresDriver

func configureDatabase(for app: Application) throws {
    guard let databaseHostname = Environment.get("FEEDBACK_POSTGRES_HOST") else {
        throw Abort(.internalServerError)
    }
    guard let databasePort = Environment.get("FEEDBACK_POSTGRES_PORT") else {
        throw Abort(.internalServerError)
    }
    guard let databaseUsername = Environment.get("FEEDBACK_POSTGRES_USERNAME") else {
        throw Abort(.internalServerError)
    }
    guard let databasePassword = Environment.get("FEEDBACK_POSTGRES_PASSWORD") else {
        throw Abort(.internalServerError)
    }
    guard let databaseName = Environment.get("FEEDBACK_POSTGRES_DB") else {
        throw Abort(.internalServerError)
    }

    app.databases.use(.postgres(
        hostname: databaseHostname,
        port: Int(databasePort)!,
        username: databaseUsername,
        password: databasePassword,
        database: databaseName
    ), as: .psql)
}
