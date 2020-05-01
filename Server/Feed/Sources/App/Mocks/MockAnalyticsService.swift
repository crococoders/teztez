//
//  File.swift
//
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation
import Models

protocol AnalyticsService {
    func fetchStatistics(count: Int) -> [StatisticsBlock]
}

final class MockAnalyticsService: AnalyticsService {
    private let factory: StatisticsBlockFactory

    init(factory: StatisticsBlockFactory = .init()) {
        self.factory = factory
    }

    func fetchStatistics(count: Int) -> [StatisticsBlock] {
        var result: [StatisticsBlock] = []
        for _ in 0 ..< count {
            result.append(factory.getRandomStatisticsBlock())
        }
        return result
    }
}

final class StatisticsBlockFactory {
    private let titleProvider: RandomStringProvider
    private let subtitleProvider: RandomStringProvider
    private let colorProvider: RandomStringProvider

    init(titleProvider: RandomStringProvider = StatisticsTitleProvider(),
         subtitleProvider: RandomStringProvider = StatisticsSubtitleProvider(),
         colorProvider: RandomStringProvider = ColorProvider()) {
        self.titleProvider = titleProvider
        self.subtitleProvider = subtitleProvider
        self.colorProvider = colorProvider
    }

    func getRandomStatisticsBlock() -> StatisticsBlock {
        StatisticsBlock(icon: nil,
                        title: titleProvider.getRandom(),
                        subtitle: subtitleProvider.getRandom(),
                        number: Int.random(in: 1 ..< 1000),
                        color: colorProvider.getRandom())
    }
}
