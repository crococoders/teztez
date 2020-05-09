//
//  SettingsURLVieWModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

struct SettingsWebViewModel {
    let title: String
    let documentURL: URL?

    init(title: String, documentURLString: String) {
        self.title = title
        documentURL = URL(string: documentURLString)
    }
}
