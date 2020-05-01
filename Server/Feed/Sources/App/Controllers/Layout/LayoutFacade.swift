//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

final class LayoutFacade {
    
    private let strategy: LayoutStrategy
    
    init(statisticsModels: [StatisticsBlock], informationModels: [InformationBlock]) {
        let statisticsLayoutStep = StatisticsBlocksLayoutStrategyStep(models: statisticsModels)
        let informationLayoutStep = InformationBlocksLayoutStrategyStep(models: informationModels)
        self.strategy = LayoutStrategy(steps: [statisticsLayoutStep, informationLayoutStep])
    }
    
    func getBlocks() -> [Block] {
        strategy.getResult()
    }
}
