//
//  SchulteConfiguration.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct SchulteConfiguration {
    let isInversed: Bool
    var nextNumber: Int
    var totalSeconds: Int

    init(isInversed: Bool, totalSeconds: Int = 0) {
        self.isInversed = isInversed
        self.totalSeconds = totalSeconds
        nextNumber = isInversed ? 25 : 1
    }
}
