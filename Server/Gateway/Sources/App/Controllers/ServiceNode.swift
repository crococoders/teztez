//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

final class ServiceNode {
    let path: PathComponent
    let host: String?
    
    init(path: String, host: String) {
        self.path = PathComponent.constant(path)
        self.host = Environment.get(host)
    }
}
