//
//  File.swift
//  
//
//  Created by Temirkhan Sailau on 5/6/20.
//

import Vapor

func configureMigrations(for app: Application) throws {
    app.migrations.add(CreateEvent())
    try app.autoMigrate().wait()
}
