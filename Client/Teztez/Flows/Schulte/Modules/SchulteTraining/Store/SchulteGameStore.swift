//
//  SchulteGameStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

private enum Constants {
    static let timeInterval = 1.0
    static let minNumber = 1
    static let maxNumber = 25
}

// TODO: Refactor whole module
final class SchulteTrainingStore {
    enum Action {
        case didLoadView
        case didSelectItemAt(index: Int)
        case didTapBackButton
    }

    enum State {
        case initial(viewModels: [SchulteTrainingViewModel], isInversed: Bool)
        case nextNumberUpdated(number: Int)
        case updated(index: Int, viewModels: [SchulteTrainingViewModel])
        case timerUpdated(formattedTime: String)
        case configured(configuration: SchulteConfiguration)
        case finished(formattedTime: String)
    }

    private var configuration: SchulteConfiguration
    private var timer: Timer?
    private var totalTimeInSeconds: Int
    private var nextNumber: Int
    private var viewModels: [SchulteTrainingViewModel] = []

    @Published private(set) var state: State?

    init(configuration: SchulteConfiguration) {
        self.configuration = configuration
        totalTimeInSeconds = configuration.totalSeconds
        nextNumber = configuration.nextNumber
        generateInitialViewModels()
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(viewModels: viewModels, isInversed: configuration.isInversed)
            state = .timerUpdated(formattedTime: timeString(time: TimeInterval(totalTimeInSeconds)))
            state = .nextNumberUpdated(number: nextNumber)
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timeInterval, repeats: true) { [weak self] _ in
                self?.startTimer()
            }
        case let .didSelectItemAt(index):
            configuration.isInversed ? validateInversedViewModelAt(index: index) : validateViewModelAt(index: index)
        case .didTapBackButton:
            timer?.invalidate()
            configuration.nextNumber = nextNumber
            configuration.totalSeconds = totalTimeInSeconds
            state = .configured(configuration: configuration)
        }
    }

    private func generateInitialViewModels() {
        for number in 1 ... 25 {
            viewModels.append(SchulteTrainingViewModel(number: "\(number)", state: .none))
        }
        viewModels.shuffle()
    }

    private func startTimer() {
        totalTimeInSeconds += 1
        state = .timerUpdated(formattedTime: timeString(time: TimeInterval(totalTimeInSeconds)))
    }

    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

    private func validateViewModelAt(index: Int) {
        let viewModel = viewModels[index]
        if nextNumber == Int(viewModel.number) {
            nextNumber += 1
            guard nextNumber <= Constants.maxNumber else { return finishTraining() }
            state = .nextNumberUpdated(number: nextNumber)
            updateViewModelStateAt(index: index, isCorrect: true)
        } else {
            updateViewModelStateAt(index: index, isCorrect: false)
        }
    }

    private func validateInversedViewModelAt(index: Int) {
        let viewModel = viewModels[index]
        if nextNumber == Int(viewModel.number) {
            nextNumber -= 1
            guard nextNumber >= Constants.minNumber else { return finishTraining() }
            state = .nextNumberUpdated(number: nextNumber)
            updateViewModelStateAt(index: index, isCorrect: true)
        } else {
            updateViewModelStateAt(index: index, isCorrect: false)
        }
    }

    private func updateViewModelStateAt(index: Int, isCorrect: Bool) {
        if isCorrect {
            viewModels[index].state = .correct
            state = .updated(index: index, viewModels: viewModels)
            viewModels[index].state = .none
        } else {
            viewModels[index].state = .incorrect
            state = .updated(index: index, viewModels: viewModels)
            viewModels[index].state = .none
        }
    }

    private func finishTraining() {
        timer?.invalidate()
        state = .finished(formattedTime: timeString(time: TimeInterval(totalTimeInSeconds)))
    }

    deinit {
        timer?.invalidate()
    }
}
