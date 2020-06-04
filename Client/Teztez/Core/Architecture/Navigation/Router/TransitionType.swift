//
//  TransitionType.swift
//  Altel
//
//  Created by Aidar Nugmanov on 4/13/20.
//  Copyright © 2020 Azimut Labs. All rights reserved.
//

enum TransitionType {
    case push
    case presentInSheet(dismissable: Bool)
    case presentInFullScreen(animated: Bool)
    case presentAsPage
}
