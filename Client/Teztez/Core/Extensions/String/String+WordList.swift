//
//  String+WordList.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/2/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

extension String {
    var wordList: [String] {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }
}
