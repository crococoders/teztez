//
//  ActivitiesIntroBlockViewModelFactory.swift
//  Teztez
//
//  Created by Adlet on 4/27/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

final class ActivitiesIntroBlockViewModelFactory {
    static func makeBlocks(for type: ActivitiesRowType) -> [ActivitiesIntroBlockViewModel] {
        switch type {
        case .backwards:
            return makeBlocksForBackward()
        case .blender:
            return makeBlockForBlender()
        case .colorMatch:
            return makeBlockForColorMatching()
        case .schulte:
            return makeBlockForSchulte()
        case .coach:
            return []
        case .suggestion:
            return []
        }
    }

    private static func makeBlocksForBackward() -> [ActivitiesIntroBlockViewModel] {
        return [ActivitiesIntroBlockViewModel(title: R.string.activitiesIntro.backwardsInfoTitle(),
                                              description: R.string.activitiesIntro.backwardsInfoDescription(),
                                              icon: R.image.activityInfoIcon()),
                ActivitiesIntroBlockViewModel(title: R.string.activitiesIntro.activityUsageTitle(),
                                              description: R.string.activitiesIntro.backwardsUsageDescription(),
                                              icon: R.image.activityUsageIcon())]
    }

    private static func makeBlockForBlender() -> [ActivitiesIntroBlockViewModel] {
        return [ActivitiesIntroBlockViewModel(title: R.string.activitiesIntro.blenderInfoTitle(),
                                              description: R.string.activitiesIntro.blenderInfoDescription(),
                                              icon: R.image.activityInfoIcon()),
                ActivitiesIntroBlockViewModel(title: R.string.activitiesIntro.activityUsageTitle(),
                                              description: R.string.activitiesIntro.blenderUsageDescription(),
                                              icon: R.image.activityUsageIcon())]
    }

    private static func makeBlockForSchulte() -> [ActivitiesIntroBlockViewModel] {
        return [ActivitiesIntroBlockViewModel(title: R.string.activitiesIntro.schulteInfoTitle(),
                                              description: R.string.activitiesIntro.schulteInfoDescription(),
                                              icon: R.image.activityInfoIcon()),
                ActivitiesIntroBlockViewModel(title: R.string.activitiesIntro.activityUsageTitle(),
                                              description: R.string.activitiesIntro.schulteUsageDescription(),
                                              icon: R.image.activityUsageIcon())]
    }

    private static func makeBlockForColorMatching() -> [ActivitiesIntroBlockViewModel] {
        return [ActivitiesIntroBlockViewModel(title: R.string.activitiesIntro.matchingInfoTitle(),
                                              description: R.string.activitiesIntro.matchingInfoDescription(),
                                              icon: R.image.activityInfoIcon()),
                ActivitiesIntroBlockViewModel(title: R.string.activitiesIntro.activityUsageTitle(),
                                              description: R.string.activitiesIntro.matchingUsageDescription(),
                                              icon: R.image.activityUsageIcon())]
    }
}
