//
//  File.swift
//
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

typealias RandomStringProvider = RandomElementProvider<String>

final class TitleProvider: RandomStringProvider {
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

final class SubtitleProvider: RandomStringProvider {
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

class RandomElementProvider<E> {
    private let array: [E]

    init(array: [E]) {
        self.array = array
    }

    func getRandom() -> E {
        return array.randomElement()!
    }
}
