//
//  SettingsSecionType.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation
import Models

enum SettingsRowType {
    case profile(viewModel: SettingsProfileViewModel)
    case web(viewModel: SettingsWebViewModel)
}

enum SettingsSectionType {
    case profile(rows: [SettingsRowType])
    case appereance(rows: [SettingsRowType])
    case document(rows: [SettingsRowType])
}
