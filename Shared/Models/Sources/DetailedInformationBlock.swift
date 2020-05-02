//
//  DetailedInformationBlock.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public struct DetailedInformationBlock: Codable {
    let coverImage: String
    let metaTitle: String
    let title: String
    let subtitle: String
    
    public init(coverImage: String, metaTitle: String, title: String, subtitle: String) {
        self.coverImage = coverImage
        self.metaTitle = metaTitle
        self.title = title
        self.subtitle = subtitle
    }
}
