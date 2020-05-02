//
//  File.swift
//
//
//  Created by Temirkhan Sailau on 4/30/20.
//
import Vapor

func configureMigrations(for app: Application) throws {
    app.migrations.add(CreateGameContent())
    app.migrations.add(CreateArticle())
    try app.autoMigrate().wait()
}
