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
    private var type: ActivityIntroType

    var colors: [CGColor] {
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

    var activityTitle: String {
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

    var activityImage: UIImage? {
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

    var activityInfoTitle: String {
        switch type {
        case .backward:
            return R.string.activitiesIntro.backwardsInfoTitle()
        case .blender:
            return R.string.activitiesIntro.blenderInfoTitle()
        case .schulte:
            return R.string.activitiesIntro.schulteInfoTitle()
        case .colorMatch:
            return R.string.activitiesIntro.matchingInfoTitle()
        }
    }

    var activityInfoDescription: String {
        switch type {
        case .backward:
            return R.string.activitiesIntro.backwardsInfoDescription()
        case .blender:
            return R.string.activitiesIntro.blenderInfoDescription()
        case .schulte:
            return R.string.activitiesIntro.schulteInfoDescription()
        case .colorMatch:
            return R.string.activitiesIntro.matchingInfoDescription()
        }
    }

    var activityInfoImage: UIImage? {
        return R.image.activityInfoIcon()
    }

    var activityUsageTitle: String {
        return R.string.activitiesIntro.activityUsageTitle()
    }

    var activityUsageDescription: String {
        switch type {
        case .backward:
            return R.string.activitiesIntro.backwardsUsageDescription()
        case .blender:
            return R.string.activitiesIntro.blenderUsageDescription()
        case .schulte:
            return R.string.activitiesIntro.schulteUsageDescription()
        case .colorMatch:
            return R.string.activitiesIntro.matchingUsageDescription()
        }
    }

    var activityUsageImage: UIImage? {
        return R.image.activityUsageIcon()
    }

    init(type: ActivityIntroType) {
        self.type = type
    }
}
