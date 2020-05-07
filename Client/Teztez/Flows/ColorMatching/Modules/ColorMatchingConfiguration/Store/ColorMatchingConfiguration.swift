//
//  ColorMatchingConfiguration.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct ColorMatchingConfiguration {
    var duration: Int
    var score: Int

    init(duration: Int, score: Int) {
        self.duration = duration
        self.score = score
    }
}
