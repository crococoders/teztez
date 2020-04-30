//
//  Array+Extension.swift
//  Teztez
//
//  Created by Adlet on 4/26/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

extension Array {
    init(count: Int, factory: @autoclosure () -> Element) {
        self = (0 ..< count).map { _ in factory() }
    }

    init(count: Int, factory: () -> Element) {
        self = (0 ..< count).map { _ in factory() }
    }
}
