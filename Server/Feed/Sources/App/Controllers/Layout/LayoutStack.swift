//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

struct LayoutStack {
    private var array: [LayoutWeightable] = []
    private var weightSum = 0

    mutating func push(_ element: LayoutWeightable) {
        array.append(element)
        weightSum += element.weight.rawValue
    }

    func isAligned() -> Bool {
        return weightSum.isMultiple(of: 2)
    }
}
