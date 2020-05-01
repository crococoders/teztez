//
//  FeedController.swift
//  App
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Vapor

final class FeedController: RouteCollection {
    private let analyticsService: AnalyticsService

    init(analyticsService: AnalyticsService = MockAnalyticsService(factory: .init())) {
        self.analyticsService = analyticsService
    }

    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("feed")
        group.get("", use: get)
    }

    private func get(request: Request) -> String {
        return ""
    }
}

protocol LayoutWeightable {
    var weight: LayoutWeight { get }
}

enum LayoutWeight: Int {
    case half = 1
    case full = 2
}

extension LayoutWeight {
    var random: LayoutWeight {
        let rawValue = Bool.random() ? 2 : 1
        return LayoutWeight(rawValue: rawValue)!
    }
}

extension LayoutType: LayoutWeightable {
    var weight: LayoutWeight {
        switch self {
        case .small:
            return .half
        case .big, .huge, .long:
            return .full
        }
    }
}

final class BlockLayoutStrategy {
    private let blocks: [StatisticsBlock]
    private var stack = LayoutStack()
    
    init(blocks: [StatisticsBlock]) {
        self.blocks = blocks
    }
    
    func getBlocks() -> [Block] {
        var result: [Block] = []
        blocks.forEach {
            let next = getNext(block: $0)
            result.append(next)
        }
        return result
    }
    
    private func getNext(block: StatisticsBlock) -> Block {
        guard isAligned() else {
            return Block.statistics(layoutType: .small, model: block)
        }
        let choice = Bool.random()
        if choice {
            let oneMoreChoice = Bool.random()
            let layoutType: LayoutType = oneMoreChoice ? .big : .long
            return Block.statistics(layoutType: layoutType, model: block)
        } else {
            return Block.statistics(layoutType: .small, model: block)
        }
    }
    
    private func isAligned() -> Bool {
        guard let top = stack.peek() else {
            return true
        }
        return top.weight == .full
    }
}

typealias LayoutStack = Stack<LayoutWeightable>

struct Stack<Element> {
    private var array: [Element] = []

    mutating func push(_ element: Element) {
        array.append(element)
    }

    mutating func pop() -> Element? {
        return array.popLast()
    }

    func peek() -> Element? {
        return array.last
    }
}
