//
//  String+Replacing.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

extension String {
    func replacingOccurrences(of strings: [String], with replacement: String) -> String {
        var newString = self
        strings.forEach { newString = newString.replacingOccurrences(of: $0, with: replacement) }
        return newString
    }
}
