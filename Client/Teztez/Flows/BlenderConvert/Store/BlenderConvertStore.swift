//
//  BlenderConvertStore.swift
//  Teztez
//
//  Created by Adlet on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import UIKit

final class BlenderConvertStore {
    enum Action {
        case didLoadView
        case didConverText
    }

    enum State {
        case initial(text: String, fontSize: CGFloat)
        case converted(text: String, fontSize: CGFloat)
    }

    @Published private(set) var state: State?

    private var configuration: BlenderConfiguration

    init(configuration: BlenderConfiguration) {
        self.configuration = configuration
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(text: configuration.text, fontSize: configuration.fontSize)
        case .didConverText:
            let convertedText = makeBlender(with: configuration.text)
            state = .converted(text: convertedText, fontSize: configuration.fontSize)
        }
    }

    // swiftlint:disable all
    private func makeBlender(with text: String) -> String {
        let regex = try! NSRegularExpression(pattern: "(?<=[A-Za-z])([A-Za-z]){2,}(?=[a-zA-Z])")
        let words = text.split(separator: " ")
        let convertedText = words.map { list -> String in
            var word = String(list)
            let results = regex.matches(in: word, range: NSRange(location: 0, length: word.count))
            for result in results {
                word.replaceSubrange(Range(result.range, in: word)!, with: word[Range(result.range, in: word)!].shuffled())
            }
            return word
        }
        return convertedText.joined(separator: " ")
    }
}
