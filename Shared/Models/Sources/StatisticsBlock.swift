//
//  StatisticsBlock.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public struct StatisticsBlock: Codable {
    let icon: String?
    let title: String
    let subtitle: String
    let number: Int
    let color: String
    
    public init(icon: String?, title: String, subtitle: String, number: Int, color: String) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.number = number
        self.color = color
    }
}
