//
//  ActionBlock.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public struct ActionBlock: Codable {
    public let icon: String?
    public let title: String
    public let subtitle: String?
    public let action: String
    
    public init(icon: String?, title: String, subtitle: String?, action: String) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
}
