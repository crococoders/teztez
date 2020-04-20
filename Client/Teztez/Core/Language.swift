//
//  Language.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

enum Language: String, CaseIterable {
    case eng
}

extension Language {
    static var preferredLanguages: [String] {
        return [current.rawValue]
    }

    static var current: Language {
        get {
            if let rawValue = UserDefaultsStorage.currentLanguage,
                let language = Language(rawValue: rawValue) {
                return language
            } else {
                if let rawValue = Bundle.main.preferredLocalizations.first ?? Locale.current.languageCode,
                    let language = Language(rawValue: rawValue) {
                    return language
                } else {
                    return .eng
                }
            }
        }
        set {
            UserDefaultsStorage.currentLanguage = newValue.rawValue
        }
    }

    var locale: Locale {
        return Locale(identifier: rawValue)
    }
}

private extension UserDefaultsStorage {
    @UserDefaultsOptionalEntry("currentLanguage")
    static var currentLanguage: String?
}
