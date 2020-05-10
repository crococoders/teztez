//
//  File.swift
//
//
//  Created by Aidar Nugmanov on 4/25/20.
//

import Vapor

enum Service: CaseIterable {
    case content
    case feed
    case feedback
    case analytics
}

extension Service {
    var path: PathComponent {
        switch self {
        case .content:
            return PathComponent.constant("content")
        case .feed:
            return PathComponent.constant("feed")
        case .feedback:
            return PathComponent.constant("feedback")
        case .analytics:
            return PathComponent.constant("analytics")
        }
    }
    
    var host: String? {
        switch self {
        case .content:
            return Environment.get("CONTENT_HOST")
        case .feed:
            return Environment.get("FEED_HOST")
        case .feedback:
            return Environment.get("FEEDBACK_HOST")
        case .analytics:
            return Environment.get("ANALYTICS_HOST")
        }
    }

    var port: String? {
        switch self {
        case .content:
            return Environment.get("CONTENT_PORT")
        case .feed:
            return Environment.get("FEED_PORT")
        case .feedback:
            return Environment.get("FEEDBACK_PORT")
        case .analytics:
            return Environment.get("ANALYTICS_PORT")
        }
    }
}
