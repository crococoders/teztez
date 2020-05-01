//
//  File.swift
//
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation
import Models

protocol ContentService {
    func fetchInformation(count: Int) -> [InformationBlock]
}

final class MockContentService: ContentService {
    private let factory: InformationBlocksFactory

    init(factory: InformationBlocksFactory = .init()) {
        self.factory = factory
    }

    func fetchInformation(count: Int) -> [InformationBlock] {
        var result: [InformationBlock] = []
        for _ in 0 ..< count {
            result.append(factory.getRandomInformationBlock())
        }
        return result
    }
}

final class InformationBlocksFactory {
    private let metaTitleProvider: RandomStringProvider
    private let titleProvider: RandomStringProvider
    private let subtitleProvider: RandomStringProvider
    private let coverImageProvider: RandomStringProvider

    init(metaTitleProvider: RandomStringProvider = InformationMetaTitleProvider(),
         titleProvider: RandomStringProvider = InformationTitleProvider(),
         subtitleProvider: RandomStringProvider = InformationSubtitleProvider(),
         coverImageProvider: RandomStringProvider = InformationCoverImageProvider()) {
        self.metaTitleProvider = metaTitleProvider
        self.titleProvider = titleProvider
        self.subtitleProvider = subtitleProvider
        self.coverImageProvider = coverImageProvider
    }

    func getRandomInformationBlock() -> InformationBlock {
        if Bool.random() {
            return .detailed(date: Date.randomWithinDaysBeforeToday(7),
                             model: .init(coverImage: coverImageProvider.getRandom(),
                                          metaTitle: metaTitleProvider.getRandom(),
                                          title: titleProvider.getRandom(),
                                          subtitle: subtitleProvider.getRandom()))
        } else {
            return .headlined(date: Date.randomWithinDaysBeforeToday(7),
                              model: .init(coverImage: coverImageProvider.getRandom(),
                                           metaTitle: metaTitleProvider.getRandom(),
                                           title: titleProvider.getRandom()))
        }
    }
}
