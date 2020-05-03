//
//  CGFloat+Clean.swift
//  Teztez
//
//  Created by Adlet on 5/3/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

extension CGFloat: LosslessStringConvertible {
    public init(_ description: String) {
        self.init()
    }

    var clean: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
