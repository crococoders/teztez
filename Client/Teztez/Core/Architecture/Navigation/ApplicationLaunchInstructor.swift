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
}

final class ApplicationLaunchInstructor {
    var flow: ApplicationLaunchInstruction {
        return .main
    }
}
