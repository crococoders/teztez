//
//  FeedsItemType.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum FeedsItemType {
    case statisticsSmall(viewModel: StatisticsSmallViewModel)
    case statisticsLong(vieWModel: StatisticsLongViewModel)
    case statisticsBig(viewModel: StatisticsSmallViewModel)
    case informationHeadlined(viewModel: InformationHeadlinedViewModel)
}
