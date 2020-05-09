//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/7/20.
//

import Fluent
import FluentPostgresDriver
import Vapor

func configureDatabase(for app: Application) throws {
    guard let databaseHostname = Environment.get("AUTH_POSTGRES_HOST"),
        let databasePort = Environment.get("AUTH_POSTGRES_PORT"),
        let databaseUsername = Environment.get("AUTH_POSTGRES_USERNAME"),
        let databasePassword = Environment.get("AUTH_POSTGRES_PASSWORD"),
        let databaseName = Environment.get("AUTH_POSTGRES_DB")
    else {
        throw Abort(.internalServerError)
    }
    app.databases.use(.postgres(hostname: databaseHostname,
                                port: Int(databasePort)!,
                                username: databaseUsername,
                                password: databasePassword,
                                database: databaseName), as: .psql)
}
