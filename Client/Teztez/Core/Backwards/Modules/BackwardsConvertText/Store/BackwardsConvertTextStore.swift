//
//  BackwardsConvertTextStore.swift
//  Teztez
//
//  Created by Adlet on 01/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import UIKit

final class BackwardsConvertTextStore {
    enum Action {
        case didLoadView
        case didConverText
    }

    enum State {
        case initial(text: String, fontSize: CGFloat)
        case converted(text: String, fontSize: CGFloat)
    }

    @Published private(set) var state: State?

    private var configuration: BackwardsConfiguration

    init(configuration: BackwardsConfiguration) {
        self.configuration = configuration
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(text: configuration.text, fontSize: configuration.fontSize)
        case .didConverText:
            let convertedText = makeBackwards(with: configuration.text)
            state = .converted(text: convertedText, fontSize: configuration.fontSize)
        }
    }

    // swiftlint:disable all
    private func makeBackwards(with text: String) -> String {
        let regex = try! NSRegularExpression(pattern: "([A-Za-z])\\w+")
        let words = text.split(separator: " ")
        let convertedText = words.map { list -> String in
            var word = String(list)
            let results = regex.matches(in: word, range: NSRange(location: 0, length: word.count))
            for result in results {
                word.replaceSubrange(Range(result.range, in: word)!, with: word[Range(result.range, in: word)!].reversed())
            }
            return word
        }
        return convertedText.joined(separator: " ")
    }
}
