//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/7/20.
//

import Foundation

public struct TokenResponse: Codable {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}
