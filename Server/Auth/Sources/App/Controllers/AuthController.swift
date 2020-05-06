//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/5/20.
//

import Fluent
import Vapor

struct AuthController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let authRoutes = routes.grouped("auth")
        authRoutes.post("register", use: register)
        let passwordProtected = authRoutes.grouped(User.authenticator())
        passwordProtected.post("login", use: login)
        let tokenProtected = authRoutes.grouped(UserToken.authenticator())
        tokenProtected.get("profile", use: profile)
    }

    func register(request: Request) throws -> EventLoopFuture<User> {
        try User.Create.validate(request)
        let create = try request.content.decode(User.Create.self)
        guard create.password == create.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords do not match")
        }
        let user = try User(
            name: create.name,
            username: create.username,
            passwordHash: Bcrypt.hash(create.password)
        )
        return user.save(on: request.db)
            .map { user }
    }
    
    func login(request: Request) throws -> EventLoopFuture<UserToken> {
        let user = try request.auth.require(User.self)
        let tokenExistsFuture = UserToken.query(on: request.db).filter(\.$user.$id, .equal, user.id!).first()
        return tokenExistsFuture.flatMap { (tokenExists) -> EventLoopFuture<UserToken> in
            do {
                let token = try user.generateToken()
                if let tokenExists = tokenExists {
                    tokenExists.value = token.value
                    tokenExists.createdAt = token.createdAt
                    return tokenExists.update(on: request.db).map { tokenExists }
                } else {
                    return token.save(on: request.db).map { token }
                }
            } catch {
                return request.eventLoop.makeFailedFuture(error)
            }
        }
    }
    
    func profile(request: Request) throws -> User {
        try request.auth.require(User.self)
    }
}
