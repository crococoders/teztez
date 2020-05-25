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
    static let animationTime = 0.5
    static let animationTextChangeTimeInterval = 0.1
}

final class BlenderConvertStore {
    enum Action {
        case didLoadView
        case didConvertText
        case didReturnText
        case didSendAnalytics
        case didStopGame
    }

    enum State {
        case initial(text: String, fontSize: CGFloat)
        case converted(text: String, fontSize: CGFloat)
        case returned(text: String, fontSize: CGFloat)
        case animating(text: String)
    }

    @Published private(set) var state: State?

    private var configuration: BlenderConfiguration
    private var analyticsProvider: AnalyticsProvider
    private var analyticEvents: [AnalyticsEvent] = []
    private var timer: Timer?
    private var backwardsAnimationTimer: Timer?
    private var secondsSpentInGame = Constants.defaultTime

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
        case .didConvertText:
            setupAnimationState { [weak self] in
                guard let self = self else { return }
                let convertedText = self.makeBlender(with: self.configuration.text)
                self.state = .converted(text: convertedText, fontSize: self.configuration.fontSize)
            }
        case .didReturnText:
            setupAnimationState { [weak self] in
                guard let self = self else { return }
                self.state = .returned(text: self.configuration.text, fontSize: self.configuration.fontSize)
            }
        case .didSendAnalytics:
            sendAnalytics()
        case .didStopGame:
            timer?.invalidate()
        }
    }

    private func setupAnimationState(completion: @escaping Callback) {
        backwardsAnimationTimer?.invalidate()
        var textChangeCount = 0.0
        backwardsAnimationTimer = Timer.scheduledTimer(withTimeInterval: Constants.animationTextChangeTimeInterval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            textChangeCount += 0.1
            let text = self.makeBlender(with: self.configuration.text)
            self.state = .animating(text: text)

            if textChangeCount > Constants.animationTime {
                self.backwardsAnimationTimer?.invalidate()
                completion()
            }
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

        let gamesPlayed = AnalyticsEvent(gameType: .backwards, eventType: .gamePlayed)

        [numberOfWordsRead, spentTime, gamesPlayed].forEach { analyticEvents.append($0) }
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

    deinit {
        timer?.invalidate()
        backwardsAnimationTimer?.invalidate()
    }
}
