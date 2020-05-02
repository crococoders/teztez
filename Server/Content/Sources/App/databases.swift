//
//  File.swift
//
//
//  Created by Temirkhan Sailau on 4/30/20.
//

import Fluent
import FluentPostgresDriver
import Vapor

func configureDatabase(for app: Application) throws {
    guard let databaseHostname = Environment.get("CONTENT_POSTGRES_HOST"),
        let databasePort = Environment.get("CONTENT_POSTGRES_PORT"),
        let databaseUsername = Environment.get("CONTENT_POSTGRES_USERNAME"),
        let databasePassword = Environment.get("CONTENT_POSTGRES_PASSWORD"),
        let databaseName = Environment.get("CONTENT_POSTGRES_DB")
    else {
        throw Abort(.internalServerError)
    }
    app.databases.use(.postgres(hostname: databaseHostname,
                                port: Int(databasePort)!,
                                username: databaseUsername,
                                password: databasePassword,
                                database: databaseName), as: .psql)
}
