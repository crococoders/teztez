//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/7/20.
//

import Vapor

func configureMigrations(for app: Application) throws {
    app.migrations.add(User.Migration())
    app.migrations.add(UserToken.Migration())
    try app.autoMigrate().wait()
}
