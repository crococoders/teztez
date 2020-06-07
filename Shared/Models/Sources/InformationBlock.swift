//
//  InformationBlock.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public enum InformationBlockType: String, Codable {
    case headlined
    case detailed
}

public enum InformationBlock {
    case headlined(date: Date, model: HeadlinedInformationBlock)
    case detailed(date: Date, model: DetailedInformationBlock)
}

public extension InformationBlock {
    var type: InformationBlockType {
        switch self {
        case .headlined:
            return .headlined
        case .detailed:
            return .detailed
        }
    }
}

extension InformationBlock: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
        case date
        case model
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(InformationBlockType.self, forKey: .type)
        let date = try container.decode(Date.self, forKey: .date)
        
        switch type {
        case .headlined:
            let headlinedInformationBlock = try container.decode(HeadlinedInformationBlock.self, forKey: .model)
            self = .headlined(date: date, model: headlinedInformationBlock)
        case .detailed:
            let detailedInformationBlock = try container.decode(DetailedInformationBlock.self, forKey: .model)
            self = .detailed(date: date, model: detailedInformationBlock)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .type)
        
        switch self {
        case let .headlined(date, model):
            try container.encode(date, forKey: .date)
            try container.encode(model, forKey: .model)
        case let .detailed(date, model):
            try container.encode(date, forKey: .date)
            try container.encode(model, forKey: .model)
        }
    }
}
