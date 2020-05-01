//
//  File.swift
//
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation
import Models

final class LayoutStrategy {
    private let steps: [LayoutStrategyStep]
    
    init(steps: [LayoutStrategyStep]) {
        self.steps = steps
    }
    
    func getResult() -> [Block] {
        steps.flatMap { step in
            step.perform()
        }
    }
}

protocol LayoutStrategyStep {
    func perform() -> [Block]
}

final class StatisticsBlocksLayoutStrategyStep: LayoutStrategyStep {
    private let models: [StatisticsBlock]
    private var stack = LayoutStack()

    init(models: [StatisticsBlock]) {
        self.models = models
    }

    func perform() -> [Block] {
        return models.map {
            getBlock(for: $0)
        }
    }

    private func getBlock(for model: StatisticsBlock) -> Block {
        var layoutType: LayoutType
        if stack.isAligned() {
            let fullWeight = Bool.random()
            if fullWeight {
                let isBigLayout = Bool.random()
                layoutType = isBigLayout ? .big : .long
            } else {
                layoutType = .small
            }
        } else {
            layoutType = .small
        }
        stack.push(layoutType)
        return Block.statistics(layoutType: layoutType, model: model)
    }
}

final class InformationBlocksLayoutStrategyStep: LayoutStrategyStep {
    private let models: [InformationBlock]

    init(models: [InformationBlock]) {
        self.models = models
    }

    func perform() -> [Block] {
        models.map {
            Block.information(layoutType: .huge, model: $0)
        }
    }
}
