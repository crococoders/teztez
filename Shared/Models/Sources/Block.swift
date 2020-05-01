//
//  Block.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

public enum Block {
    case statistics(layoutType: LayoutType, model: StatisticsBlock)
    case action(layoutType: LayoutType, model: ActionBlock)
    case system(layoutType: LayoutType, model: SystemBlock)
    case information(layoutType: LayoutType, model: InformationBlock)
}

public extension Block {
    var type: BlockType {
        switch self {
        case .action:
            return .action
        case .information:
            return .information
        case .statistics:
            return .statistics
        case .system:
            return .system
        }
    }
}

extension Block: Codable {
    private enum CodingKeys: String, CodingKey {
        case layoutType
        case blockType
        case model
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let layoutType = try container.decode(LayoutType.self, forKey: .layoutType)
        let blockType = try container.decode(BlockType.self, forKey: .blockType)
        
        switch blockType {
        case .action:
            let actionBlock = try container.decode(ActionBlock.self, forKey: .model)
            self = .action(layoutType: layoutType, model: actionBlock)
        case .information:
            let informationBlock = try container.decode(InformationBlock.self, forKey: .model)
            self = .information(layoutType: layoutType, model: informationBlock)
        case .statistics:
            let statisticsBlock = try container.decode(StatisticsBlock.self, forKey: .model)
            self = .statistics(layoutType: layoutType, model: statisticsBlock)
        case .system:
            let systemBlock = try container.decode(SystemBlock.self, forKey: .model)
            self = .system(layoutType: layoutType, model: systemBlock)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.type, forKey: .blockType)
        
        switch self {
        case let .action(layoutType, model):
            try container.encode(layoutType, forKey: .layoutType)
            try container.encode(model, forKey: .model)
        case let .information(layoutType, model):
            try container.encode(layoutType, forKey: .layoutType)
            try container.encode(model, forKey: .model)
        case let .statistics(layoutType, model):
            try container.encode(layoutType, forKey: .layoutType)
            try container.encode(model, forKey: .model)
        case let .system(layoutType, model):
            try container.encode(layoutType, forKey: .layoutType)
            try container.encode(model, forKey: .model)
        }
    }
}
