//
//  ActivitiesIntroViewModel.swift
//  Teztez
//
//  Created by Adlet on 4/23/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

struct ActivitiesIntroViewModel {
    let iconViewModel: ActivitiesIconViewModel
    var title: String? {
        switch type {
        case .blender:
            return R.string.activities.blenderTitle()
        case .backwards:
            return R.string.activities.backwardsDescription()
        case .colorMatch:
            return R.string.activities.colorMatchingTitle()
        case .schulte:
            return R.string.activities.schulteTableTitle()
        case .coach:
            return nil
        case .suggestion:
            return nil
        }
    }

    var blocks: [ActivitiesIntroBlockViewModel] {
        return ActivitiesIntroBlockViewModelFactory.makeBlocks(for: type)
    }

    let type: ActivitiesItemType

    init(type: ActivitiesItemType) {
        self.type = type
        iconViewModel = ActivitiesIconViewModel(type: type)
    }
}
