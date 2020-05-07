//
//  DetailedInformationBlock.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public struct DetailedInformationBlock: Codable {
    public let coverImage: String
    public let metaTitle: String
    public let title: String
    public let subtitle: String
    
    public init(coverImage: String, metaTitle: String, title: String, subtitle: String) {
        self.coverImage = coverImage
        self.metaTitle = metaTitle
        self.title = title
        self.subtitle = subtitle
    }
}
