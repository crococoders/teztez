//
//  ColorMatchingTrainingStore.swift
//  Teztez
//
//  Created by Adlet on 04/06/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import UIKit

private enum Constants {
    static let timeInterval = 1.0
}

final class ColorMatchingTrainingStore {
    enum Action {
        case didLoadView
        case didTapBlockAt(index: Int)
        case didTapBackButton
    }

    enum State {
        case initial(viewModel: [ColorMatchingTrainingViewModel])
        case updated(index: Int, viewModels: [ColorMatchingTrainingViewModel])
        case updateScore(score: Int)
        case configured(configuration: ColorMatchingConfiguration)
        case timerStarted(duration: String)
        case finished(score: Int)
        case updateProgress(duration: Int)
    }

    private var configuration: ColorMatchingConfiguration
    private var timer: Timer?
    private var duration: Int
    private var currentScore: Int
    private var validatedCount: Int = 0

    private var trainingFacade: ColorMatchingTrainingFacade
    private var viewModels: [ColorMatchingTrainingViewModel] = []

    @Published private(set) var state: State?

    init(configuration: ColorMatchingConfiguration) {
        self.configuration = configuration
        duration = configuration.duration
        currentScore = configuration.score
        trainingFacade = ColorMatchingTrainingFacade()
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .updateScore(score: currentScore)
            setupColors()
            state = .timerStarted(duration: timeString(time: TimeInterval(duration)))
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timeInterval, repeats: true, block: { [weak self] _ in
                self?.startTimer()
            })
        case let .didTapBlockAt(index):
            validateSelectedBlocks(by: index)
        case .didTapBackButton:
            configuration.duration = duration
            configuration.score = currentScore
            state = .configured(configuration: configuration)
        }
    }

    private func startTimer() {
        guard duration > 1 else {
            finishGame()
            return
        }
        duration -= 1
        state = .timerStarted(duration: timeString(time: TimeInterval(duration)))
        state = .updateProgress(duration: duration)
    }

    private func setupColors() {
        trainingFacade.generateGradientColors()
        trainingFacade.sortedGradientColors.forEach { color in
            viewModels.append(ColorMatchingTrainingViewModel(gradientColors: color, state: .none))
        }
        state = .initial(viewModel: viewModels)
    }

    private func validateSelectedBlocks(by index: Int) {
        if index % 2 == 0 {
            validate(by: index, in: trainingFacade.rightBlocksGradientColors)
        } else {
            validate(by: index, in: trainingFacade.leftBlocksGradientColors)
        }
    }

    private func validate(by index: Int, in colors: [[CGColor]]) {
        let gradientColor = colors[index / 2]
        guard gradientColor == trainingFacade.correctAnswer else { return }
        validatedCount += 1
        viewModels[index].state = .correct
        state = .updated(index: index, viewModels: viewModels)
        viewModels[index].state = .none
        guard validatedCount == 2 else { return }
        updateColors()
    }

    private func updateColors() {
        currentScore += 10
        state = .updateScore(score: currentScore)
        viewModels.removeAll()
        validatedCount = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.setupColors()
        }
    }

    private func finishGame() {
        timer?.invalidate()
        state = .finished(score: currentScore)
    }

    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

    deinit {
        timer?.invalidate()
    }
}
