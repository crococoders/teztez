//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/7/20.
//

import Fluent
import Vapor
import Models

final class UserToken: Model, Content {
    static let schema = "user_tokens"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "value")
    var value: String

    @Parent(key: "user_id")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }

    init(id: UUID? = nil, value: String, userID: User.IDValue) {
        self.id = id
        self.value = value
        self.$user.id = userID
    }
}

extension TokenResponse: Content {}

extension UserToken {
    func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
        let response = Response()
        do {
            try response.content.encode(TokenResponse(token: self.value))
        } catch {
            return request.eventLoop.makeFailedFuture(error)
        }
        return request.eventLoop.makeSucceededFuture(response)
    }
}

extension UserToken {
    struct Migration: Fluent.Migration {
        var name: String { "CreateUserToken" }

        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("user_tokens")
                .id()
                .field("value", .string, .required)
                .field("user_id", .uuid, .required, .references("users", "id"))
                .field("created_at", .datetime)
                .unique(on: "value")
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("user_tokens").delete()
        }
    }
}

extension UserToken: ModelTokenAuthenticatable {
    static let valueKey = \UserToken.$value
    static let userKey = \UserToken.$user

    var isValid: Bool {
        true
    }
}
