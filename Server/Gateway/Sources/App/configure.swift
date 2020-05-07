//
//  configure.swift
//
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

public func configure(_ app: Application) throws {
    try configureDatabase(for: app)
    try configureMigrations(for: app)
    try configureRoutes(for: app)
}
