//
//  File.swift
//  
//
//  Created by Temirkhan Sailau on 5/6/20.
//

import Fluent
import FluentPostgresDriver
import Vapor

func configureDatabase(for app: Application) throws {
    guard let databaseHostname = Environment.get("ANALYTICS_POSTGRES_HOST"),
        let databasePort = Environment.get("ANALYTICS_POSTGRES_PORT"),
        let databaseUsername = Environment.get("ANALYTICS_POSTGRES_USERNAME"),
        let databasePassword = Environment.get("ANALYTICS_POSTGRES_PASSWORD"),
        let databaseName = Environment.get("ANALYTICS_POSTGRES_DB") else {
        throw Abort(.internalServerError)
    }
    app.databases.use(.postgres(hostname: databaseHostname,
                                port: Int(databasePort)!,
                                username: databaseUsername,
                                password: databasePassword,
                                database: databaseName), as: .psql)
}
