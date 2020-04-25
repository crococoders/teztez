//
//  ActivitiesViewModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/25/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let maximumSize = CGSize(width: 30, height: 30)
    static let defaultSize = CGSize(width: 25, height: 25)
    static let maximumBottomConstraint: CGFloat = 12
    static let defaultBottomConstraint: CGFloat = 8
}

struct ActivitiesViewModel {
    var colors: [CGColor] {
        switch type {
        case .coach:
            return [UIColor.sirenLight.cgColor, UIColor.sirenDark.cgColor]
        case .blender:
            return [UIColor.coralLight.cgColor, UIColor.coralDark.cgColor]
        case .backwards:
            return [UIColor.violetLight.cgColor, UIColor.violetDark.cgColor]
        case .colorMatch:
            return [UIColor.greenLight.cgColor, UIColor.greenDark.cgColor]
        case .schulte:
            return [UIColor.orangeLigt.cgColor, UIColor.orangeDark.cgColor]
        case .suggestion:
            return [UIColor.accentBlue15.cgColor, UIColor.accentBlue15.cgColor]
        }
    }

    var title: String {
        switch type {
        case .coach:
            return R.string.activities.coachTitle()
        case .blender:
            return R.string.activities.blenderTitle()
        case .backwards:
            return R.string.activities.backwardsTitle()
        case .colorMatch:
            return R.string.activities.colorMatchingTitle()
        case .schulte:
            return R.string.activities.schulteTableTitle()
        case .suggestion:
            return R.string.activities.suggestActivityTitle()
        }
    }

    var description: String? {
        switch type {
        case .coach:
            return R.string.activities.coachDescription()
        case .blender:
            return R.string.activities.blenderDescription()
        case .backwards:
            return R.string.activities.backwardsDescription()
        case .colorMatch:
            return R.string.activities.colorMatchingDescription()
        case .schulte:
            return R.string.activities.schulteTableDescription()
        case .suggestion:
            return nil
        }
    }

    var image: UIImage? {
        switch type {
        case .coach:
            return R.image.coachIcon()
        case .blender:
            return R.image.blenderIcon()
        case .backwards:
            return R.image.backwardsIcon()
        case .colorMatch:
            return R.image.matchingIcon()
        case .schulte:
            return R.image.schulteIcon()
        case .suggestion:
            return R.image.addSuggestionIcon()
        }
    }

    var iconSize: CGSize {
        switch type {
        case .coach:
            return Constants.maximumSize
        default:
            return Constants.defaultSize
        }
    }

    var isDescriptionHidden: Bool {
        switch type {
        case .suggestion:
            return true
        default:
            return false
        }
    }

    var stackViewBottomConstraint: CGFloat {
        switch type {
        case .suggestion:
            return Constants.maximumBottomConstraint
        default:
            return Constants.defaultBottomConstraint
        }
    }

    private var type: ActivitiesRowType

    init(type: ActivitiesRowType) {
        self.type = type
    }
}
