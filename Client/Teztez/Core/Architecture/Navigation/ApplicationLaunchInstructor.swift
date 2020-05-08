//
//  ApplicationLaunchInstructor.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum ApplicationLaunchInstruction {
    case main
    case auth
}

final class ApplicationLaunchInstructor {
    private let userSession = UserSession.shared

    var flow: ApplicationLaunchInstruction {
        if userSession.isExist {
            return .main
        } else {
            return .auth
        }
    }
}
