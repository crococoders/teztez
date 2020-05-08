//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/7/20.
//

import Foundation

public struct UserResponse: Codable {
    public let id: String
    public let name: String
    public let username: String
    
    public init(id: String, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
