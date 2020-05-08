//
//  StatisticsLongViewModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/7/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Models
import UIKit

struct StatisticsLongViewModel {
    let title: String
    let subtitle: String
    let valueColor: UIColor
    let value: String

    init(block: StatisticsBlock) {
        title = block.title
        subtitle = block.subtitle
        valueColor = UIColor(hex: block.color)
        value = "\(block.number)"
    }
}
