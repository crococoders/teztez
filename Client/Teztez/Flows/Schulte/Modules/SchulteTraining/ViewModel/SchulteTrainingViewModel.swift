//
//  SchulteTrainingViewModel.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum SchulteNumberState {
    case correct
    case incorrect
    case none
    case underlined
}

struct SchulteTrainingViewModel {
    let number: String
    var state: SchulteNumberState
}
