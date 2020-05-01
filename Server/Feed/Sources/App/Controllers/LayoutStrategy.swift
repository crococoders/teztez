//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

final class LayoutStrategy {
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
        return Block.statistics(layoutType: layoutType, model: block)
    }
}
