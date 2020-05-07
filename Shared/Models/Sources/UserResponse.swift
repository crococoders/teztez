//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/7/20.
//

import Foundation

public struct UserResponse: Codable {
    let id: String
    let name: String
    let username: String
    
    public init(id: String, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
