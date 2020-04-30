//
//  ActivitiesIntroViewModel.swift
//  Teztez
//
//  Created by Adlet on 4/23/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

enum ActivityIntroType {
    case backward, blender, schulte, colorMatch
}

struct ActivitiesIntroViewModel {
    let iconViewModel: ActivitiesIconViewModel
    var title: String {
        switch type {
        case .blender:
            return R.string.activities.blenderTitle()
        case .backward:
            return R.string.activities.backwardsDescription()
        case .colorMatch:
            return R.string.activities.colorMatchingTitle()
        case .schulte:
            return R.string.activities.schulteTableTitle()
        }
    }

    var blocks: [ActivitiesIntroBlockViewModel] {
        return ActivitiesIntroBlockViewModelFactory.makeBlocks(for: type)
    }

    private let type: ActivityIntroType

    init(type: ActivityIntroType) {
        self.type = type
        iconViewModel = ActivitiesIconViewModel(type: type)
    }
}
