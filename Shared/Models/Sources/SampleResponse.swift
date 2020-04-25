//
//  SampleResponse.swift
//  Shared
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Foundation

public final class SampleResponse: Codable {
    public var title: String
    public var subtitle: String

    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
