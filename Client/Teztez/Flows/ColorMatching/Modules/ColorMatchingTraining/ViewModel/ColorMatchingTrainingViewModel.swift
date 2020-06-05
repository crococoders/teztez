//
//  ColorMatchingTrainingViewModel.swift
//  Teztez
//
//  Created by Adlet on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

enum ColorMatchingTrainingState {
    case correct, none
}

struct ColorMatchingTrainingViewModel {
    var gradientColors: [CGColor]
    var state: ColorMatchingTrainingState
}
