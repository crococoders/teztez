//
//  StatisticsBlock.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public struct StatisticsBlock: Codable {
    public let icon: String?
    public let title: String
    public let subtitle: String
    public let number: Int
    public let color: String
    
    public init(icon: String?, title: String, subtitle: String, number: Int, color: String) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.number = number
        self.color = color
    }
}
