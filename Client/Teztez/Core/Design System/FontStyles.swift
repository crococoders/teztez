//
//  FontStyles.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/19/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension UIFont {
    static var displayBold32: UIFont {
        R.font.sfProDisplayBold(size: 32) ?? systemFont(ofSize: 32, weight: .bold)
    }

    static var displayBold28: UIFont {
        R.font.sfProDisplayBold(size: 28) ?? systemFont(ofSize: 28, weight: .bold)
    }

    static var displayBold22: UIFont {
        R.font.sfProDisplayBold(size: 22) ?? systemFont(ofSize: 22, weight: .bold)
    }

    static var displayMedium20: UIFont {
        R.font.sfProDisplayBold(size: 20) ?? systemFont(ofSize: 20, weight: .medium)
    }

    static var textSemibold17: UIFont {
        R.font.sfProTextSemibold(size: 17) ?? systemFont(ofSize: 17, weight: .semibold)
    }

    static var textSemibold15: UIFont {
        R.font.sfProTextSemibold(size: 15) ?? systemFont(ofSize: 15, weight: .semibold)
    }

    static var textRegulard15: UIFont {
        R.font.sfProTextRegular(size: 15) ?? systemFont(ofSize: 15, weight: .regular)
    }

    static var textSemibold13: UIFont {
        R.font.sfProTextRegular(size: 13) ?? systemFont(ofSize: 13, weight: .semibold)
    }

    static var textRegualr10: UIFont {
        R.font.sfProTextRegular(size: 10) ?? systemFont(ofSize: 10, weight: .regular)
    }

    static var roundedBold24: UIFont {
        R.font.sfProRoundedBold(size: 24) ?? systemFont(ofSize: 24, weight: .bold)
    }

    static var roundedSemibold24: UIFont {
        R.font.sfProRoundedSemibold(size: 24) ?? systemFont(ofSize: 24, weight: .semibold)
    }

    static var roundedRegular20: UIFont {
        R.font.sfProRoundedRegular(size: 20) ?? systemFont(ofSize: 20, weight: .semibold)
    }

    // MARK: Specific Font Styles for one page

    static var displayBold140: UIFont {
        R.font.sfProDisplayBold(size: 140) ?? systemFont(ofSize: 140, weight: .bold)
    }

    static var displayBold72: UIFont {
        R.font.sfProDisplayBold(size: 72) ?? systemFont(ofSize: 72, weight: .bold)
    }

    static var displayBold48: UIFont {
        R.font.sfProDisplayBold(size: 48) ?? systemFont(ofSize: 48, weight: .bold)
    }

    static var textRegualr17: UIFont {
        R.font.sfProTextRegular(size: 17) ?? systemFont(ofSize: 17, weight: .regular)
    }

    static var textRegualr13: UIFont {
        R.font.sfProTextRegular(size: 13) ?? systemFont(ofSize: 13, weight: .regular)
    }

    static var roundedRegular32: UIFont {
        R.font.sfProRoundedRegular(size: 32) ?? systemFont(ofSize: 32, weight: .semibold)
    }
}
