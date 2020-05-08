//
//  StatisticsSmallViewModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/7/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Models
import UIKit

struct StatisticsSmallViewModel {
    let title: String
    let subtitle: String
    let value: String
    let valueColor: UIColor
    let icon: UIImage?

    init(block: StatisticsBlock) {
        title = block.title
        subtitle = block.subtitle
        value = "\(block.number)"
        valueColor = UIColor(hex: block.color)
        icon = nil
    }
}
