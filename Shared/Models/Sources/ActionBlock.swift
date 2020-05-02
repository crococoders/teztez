//
//  ActionBlock.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public struct ActionBlock: Codable {
    let icon: String?
    let title: String
    let subtitle: String?
    let action: String
    
    public init(icon: String?, title: String, subtitle: String?, action: String) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
}
