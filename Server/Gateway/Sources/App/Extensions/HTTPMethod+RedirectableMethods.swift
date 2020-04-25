//
//  HTTPMethod+RedirectableMethods.swift
//  
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

extension HTTPMethod {
    public static var redirectableMethods: [HTTPMethod] {
        return [GET, PUT, POST, DELETE]
    }
}
