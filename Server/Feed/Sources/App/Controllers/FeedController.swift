//
//  FeedController.swift
//  App
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Vapor
import Models

extension Block: Content {}

final class FeedController: RouteCollection {
    private let analyticsService: AnalyticsService
    private let contentService: ContentService

    init(analyticsService: AnalyticsService = MockAnalyticsService(),
         contentService: ContentService = MockContentService()) {
        self.analyticsService = analyticsService
        self.contentService = contentService
    }

    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("feed")
        group.get("", use: get)
    }

    private func get(request: Request) -> [Block] {
        let statisticsBlocks = analyticsService.fetchStatistics(count: 10)
        let contentBlocks = contentService.fetchInformation(count: 4)
        let facade = LayoutFacade(statisticsModels: statisticsBlocks, informationModels: contentBlocks)
        return facade.getBlocks()
    }
}
