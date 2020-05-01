//
//  HeadlinedInformationBlock.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public struct HeadlinedInformationBlock: Codable {
    let coverImage: String
    let metaTitle: String
    let title: String
    
    public init(coverImage: String, metaTitle: String, title: String) {
        self.coverImage = coverImage
        self.metaTitle = metaTitle
        self.title = title
    }
}
