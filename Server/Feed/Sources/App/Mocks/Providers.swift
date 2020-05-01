//
//  File.swift
//
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation
import Models

typealias RandomStringProvider = RandomElementProvider<String>

final class StatisticsTitleProvider: RandomStringProvider {
    init() {
        super.init(array: [
            "Words",
            "Minutes",
            "Characters",
            "Hours",
            "Seconds",
            "Chances",
            "Blocks",
            "Sentences",
            "Texts"
        ])
    }
}

final class StatisticsSubtitleProvider: RandomStringProvider {
    init() {
        let gameNameProvider = GameNameProvider()
        let dateStringProvider = DateStringProvider()
        super.init(array: [
            "engaged in learning",
            "encountered in process",
            "missed since \(dateStringProvider.getRandom())",
            "encountered since \(dateStringProvider.getRandom())",
            "read since \(dateStringProvider.getRandom())",
            "breathed through in \(gameNameProvider.getRandom())",
            "passed by in \(gameNameProvider.getRandom())",
            "passed since \(dateStringProvider.getRandom())",
            "missed in \(gameNameProvider.getRandom())",
            "matched in \(gameNameProvider.getRandom())",
            "matched since \(dateStringProvider.getRandom())"
        ])
    }
}

final class GameNameProvider: RandomStringProvider {
    init() {
        super.init(array: [
            "Coach game",
            "Blender game",
            "Sdrawkcab game",
            "Backwards game",
            "Color Matching game",
            "Schulte table game"
        ])
    }
}

final class DateStringProvider: RandomStringProvider {
    init() {
        super.init(array: [
            "last week",
            "yesterday",
            "last two weeks",
            "last month",
            "last year",
            "beginning",
            "few days ago"
        ])
    }
}

final class ColorProvider: RandomStringProvider {
    init() {
        super.init(array: [
            "FD9F2B",
            "36E7BC",
            "FF3C3C",
            "3BCF5E",
            "FC3B62",
            "FED533"
        ])
    }
}

final class InformationMetaTitleProvider: RandomStringProvider {
    init() {
        super.init(array: [
            "STUDY HACK",
            "ARTICLE OF THE DAY",
            "QUICKTIP",
            "EDITOR'S PICK",
            "FEATURED",
            "OUR FAVORITE",
            "RECOMMENDED",
            "MOM SAID"
        ])
    }
}

final class InformationTitleProvider: RandomStringProvider {
    init() {
        super.init(array: [
            "Mapping Mental Models",
            "A Helpful Guide to Reading Better",
            "Choose Your Reads Wisely",
            "Why We Focus on Trivial Things",
            "The Great Mental Models",
            "The Key to Innovation",
            "How to Remember What You Read"
        ])
    }
}

final class InformationSubtitleProvider: RandomStringProvider {
    init() {
        super.init(array: [
            "In this article we outline how to improve your reading.",
            "Imagine you’re building a house. Things start off well.",
            "Why are we so optimistic in our estimation of the cost and schedule of a project?",
            "How can we stop wasting time on unimportant details?",
            "Ironically, Newton’s turn of phrase wasn’t even entirely his own. ",
            "Do we dance simply for recreation? ",
            "It’s not what they read. It’s how they read."
        ])
    }
}

final class InformationCoverImageProvider: RandomStringProvider {
    init() {
        super.init(array: [
            "https://images.unsplash.com/photo-1588272078232-b7cfbd579b8b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2134&q=80",
            "https://images.unsplash.com/photo-1587614203256-c0349650a9af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
            "https://images.unsplash.com/photo-1588091210060-1ee4fab270ae?ixlib=rb-1.2.1&auto=format&fit=crop&w=644&q=80",
            "https://images.unsplash.com/photo-1588268223190-0073d86159a3?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
            "https://images.unsplash.com/photo-1588290534520-f67089d17ec0?ixlib=rb-1.2.1&auto=format&fit=crop&w=675&q=80",
            "https://images.unsplash.com/photo-1588278508976-a232eec798be?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
            "https://images.unsplash.com/photo-1588191030512-294d40054866?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"
        ])
    }
}

class RandomElementProvider<E> {
    private let array: [E]

    init(array: [E]) {
        self.array = array
    }

    func getRandom() -> E {
        return array.randomElement()!
    }
}

extension Date {
    static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
        let today = Date()
        let earliest = today.addingTimeInterval(TimeInterval(-days*24*60*60))
        
        return Date.random(between: earliest, and: today)
    }

    static func random() -> Date {
        let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
        return Date(timeIntervalSince1970: randomTime)
    }
    
    static func random(between initial: Date, and final:Date) -> Date {
        let interval = final.timeIntervalSince(initial)
        let randomInterval = TimeInterval(arc4random_uniform(UInt32(interval)))
        return initial.addingTimeInterval(randomInterval)
    }
}
