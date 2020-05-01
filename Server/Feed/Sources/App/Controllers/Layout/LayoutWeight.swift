//
//  File.swift
//  
//
//  Created by Aidar Nugmanov on 5/1/20.
//

import Foundation

protocol LayoutWeightable {
    var weight: LayoutWeight { get }
}

enum LayoutWeight: Int {
    case half = 1
    case full = 2
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
