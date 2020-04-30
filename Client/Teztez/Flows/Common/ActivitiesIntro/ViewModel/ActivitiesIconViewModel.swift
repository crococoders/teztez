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

    var image: UIImage? {
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

    private let type: ActivityIntroType

    init(type: ActivityIntroType) {
        self.type = type
    }
}
