//
//  ActivitiesIconViewModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

struct ActivitiesIconViewModel {
    var gradientColors: [CGColor] {
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

    private let type: ActivitiesRowType

    init(type: ActivitiesRowType) {
        self.type = type
    }
}
