//
//  BlenderConvertStore.swift
//  Teztez
//
//  Created by Adlet on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let timeInterval = 1.0
    static let defaultTime = 1
}

final class BlenderConvertStore {
    enum Action {
        case didLoadView
        case didConverText
        case didSendAnalytics
        case didStopGame
    }

    enum State {
        case initial(text: String, fontSize: CGFloat)
        case converted(text: String, fontSize: CGFloat)
    }

    @Published private(set) var state: State?

    private var configuration: BlenderConfiguration
    private var analyticsProvider: AnalyticsProvider
    private var analyticEvents: [AnalyticsEvent] = []
    private var timer: Timer?
    private var secondsSpentInGame: Int = Constants.defaultTime

    init(configuration: BlenderConfiguration) {
        self.configuration = configuration
        analyticsProvider = AnalyticsProvider.shared
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(text: configuration.text, fontSize: configuration.fontSize)
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timeInterval, repeats: true) { [weak self] _ in
                self?.calculateSpentTime()
            }
        case .didConverText:
            let convertedText = makeBlender(with: configuration.text)
            state = .converted(text: convertedText, fontSize: configuration.fontSize)
        case .didSendAnalytics:
            sendAnalytics()
        case .didStopGame:
            timer?.invalidate()
        }
    }

    private func calculateSpentTime() {
        secondsSpentInGame += 1
    }

    private func getNumberOfWordsRead() -> Int {
        return configuration.text.components(separatedBy: .whitespacesAndNewlines).count
    }

    private func sendAnalytics() {
        let numberOfWordsRead = AnalyticsEvent(gameType: .blender,
                                               eventType: .numberOfWordsRead, value: getNumberOfWordsRead())
        let spentTime = AnalyticsEvent(gameType: .blender,
                                       eventType: .secondsSpentInGame, value: secondsSpentInGame)

        [numberOfWordsRead, spentTime].forEach { analyticEvents.append($0) }
        analyticsProvider.postAnalytcis(events: analyticEvents)
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
