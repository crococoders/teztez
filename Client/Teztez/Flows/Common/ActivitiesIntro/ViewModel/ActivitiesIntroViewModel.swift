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
    var gradientColors: [CGColor] {
        switch type {
        case .blender:
            return [UIColor.coralLight.cgColor, UIColor.coralDark.cgColor]
        case .backward:
            return [UIColor.violetLight.cgColor, UIColor.violetDark.cgColor]
        case .colorMatch:
            return [UIColor.greenLight.cgColor, UIColor.greenDark.cgColor]
        case .schulte:
            return [UIColor.orangeLigt.cgColor, UIColor.orangeDark.cgColor]
        }
    }

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

    var icon: UIImage? {
        switch type {
        case .blender:
            return R.image.blenderIcon()
        case .backward:
            return R.image.backwardsIcon()
        case .colorMatch:
            return R.image.matchingIcon()
        case .schulte:
            return R.image.schulteIcon()
        }
    }

    var blocks: [ActivitiesIntroBlockViewModel] {
        return ActivitiesIntroBlockViewModelFactory.makeBlocks(for: type)
    }

    private let type: ActivityIntroType

    init(type: ActivityIntroType) {
        self.type = type
    }
}
