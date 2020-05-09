//
//  PersonalCoachTrainingStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 02/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

private enum Constants {
    static let preparationSeconds = 3
    static let timerInterval = 1.0
    static let startIndex = 0
    static let speedMeasure = "wpm"
}

// TODO: Create Logic Layer (may be Facade) and move all mutating func in it
final class PersonalCoachTrainingStore {
    enum Action {
        case didLoadView
        case didTapBackButton
        case didSendAnalytics
    }

    enum State {
        case timerUpdated(second: String)
        case trainingStarted(speed: String)
        case wordUpdated(word: String)
        case finished(speed: Int)
        case paused(currentWordIndex: Int)
    }

    private let configuration: PersonalCoachConfiguration
    private let analyticsProvider: AnalyticsProvider
    private var timer: Timer?
    private var currentWordIndex: Int
    private var attemptingPreparationSeconds = Constants.preparationSeconds
    private var textWordList: [String] {
        configuration.text.wordList
    }

    private var analyticEvents: [AnalyticsEvent] = []
    private var numberOfReadWords: Int = Constants.startIndex
    private var secondsInGame: Int = 1

    @Published private(set) var state: State?

    init(configuration: PersonalCoachConfiguration) {
        self.configuration = configuration
        currentWordIndex = configuration.startWordIndex
        analyticsProvider = AnalyticsProvider.shared
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timerInterval, repeats: true) { [weak self] _ in
                self?.startTimer()
            }
        case .didTapBackButton:
            timer?.invalidate()
            state = .paused(currentWordIndex: currentWordIndex)
        case .didSendAnalytics:
            sendAnalytics()
        }
    }

    private func startTimer() {
        guard attemptingPreparationSeconds != 1 else {
            timer?.invalidate()
            state = .trainingStarted(speed: "\(configuration.speed) " + Constants.speedMeasure)
            prepareTraining()
            return
        }

        attemptingPreparationSeconds -= 1
        state = .timerUpdated(second: "\(attemptingPreparationSeconds)")
    }

    private func prepareTraining() {
        let timeInterval = 1.0 / (Double(configuration.speed) / 60.0)
        print(timeInterval)
        state = .wordUpdated(word: textWordList[currentWordIndex])
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
            self?.startTrainting()
        }
    }

    private func startTrainting() {
        guard currentWordIndex < textWordList.count - 1 else {
            timer?.invalidate()
            state = .finished(speed: configuration.speed)
            return
        }
        currentWordIndex += 1
        numberOfReadWords += 1
        secondsInGame += 1
        state = .wordUpdated(word: textWordList[currentWordIndex])
    }

    deinit {
        timer?.invalidate()
    }

    private func sendAnalytics() {
        let words = AnalyticsEvent(gameType: .personalCoach, eventType: .numberOfWordsRead, value: numberOfReadWords)
        let speed = AnalyticsEvent(gameType: .personalCoach, eventType: .wpmSpeedChosen, value: configuration.speed)
        let time = AnalyticsEvent(gameType: .personalCoach, eventType: .secondsSpentInGame, value: secondsInGame)

        [speed, words, time].forEach { analyticEvents.append($0) }
        analyticsProvider.postAnalytcis(events: analyticEvents)
    }
}
