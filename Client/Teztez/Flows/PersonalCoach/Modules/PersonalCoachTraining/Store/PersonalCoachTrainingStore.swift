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
        case didSetLastWordIndex(index: Int)
    }

    enum State {
        case timerUpdated(second: String)
        case trainingStarted(speed: String)
        case wordUpdated(word: String)
        case finished(speed: Int)
        case paused(currentWordIndex: Int)
    }

    private let configuration: PersonalCoachConfiguration
    private var timer: Timer?
    private var attemptingPreparationSeconds = Constants.preparationSeconds
    private var currentWordIndex = Constants.startIndex
    private var textWordList: [String] {
        configuration.text.wordList
    }

    @Published private(set) var state: State?

    init(configuration: PersonalCoachConfiguration) {
        self.configuration = configuration
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
        case let .didSetLastWordIndex(currentWordIndex):
            self.currentWordIndex = currentWordIndex
        }
    }

    deinit {
        timer?.invalidate()
    }

    private func startTimer() {
        guard attemptingPreparationSeconds != 0 else {
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
        state = .wordUpdated(word: textWordList[currentWordIndex])
    }
}
