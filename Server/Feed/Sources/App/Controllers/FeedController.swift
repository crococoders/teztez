//
//  FeedController.swift
//  App
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Vapor

extension Block: Content {}

final class FeedController: RouteCollection {
    private let analyticsService: AnalyticsService

    init(analyticsService: AnalyticsService = MockAnalyticsService(factory: .init())) {
        self.analyticsService = analyticsService
    }

    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("feed")
        group.get("", use: get)
    }

    private func get(request: Request) -> [Block] {
        let statisticsBlocks = analyticsService.fetchStatistics(count: 10)
        let strategy = LayoutStrategy(blocks: statisticsBlocks)
        let response = strategy.getBlocks()
        return response
    }
}
