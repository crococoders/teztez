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

    var activityTitle: String {
        return "Title"
    }

    var activityImage: UIImage? {
        switch type {
        case .backward:
            return R.image.backwardsTitleIcon()
        default:
            return nil
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
