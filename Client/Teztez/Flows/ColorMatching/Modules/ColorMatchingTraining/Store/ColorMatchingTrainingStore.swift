//
//  ColorMatchingTrainingStore.swift
//  Teztez
//
//  Created by Adlet on 04/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import UIKit
struct ViewModel {
    var colors: [[CGColor]]
    var state: Bool
}

private enum Constants {
    static let timeInterval = 1.0
}

// TODO: - refactor whole this module
final class ColorMatchingTrainingStore {
    enum Action {
        case didLoadView
        case didTapBlockAt(index: Int)
        case didTapBackButton
    }

    enum State {
        case initial(gradientColors: [[CGColor]])
        case updateScore(score: Int)
        case timerStarted(duration: String)
        case configured(configuration: ColorMatchingConfiguration)
        case finished(score: Int)
    }

    private var configuration: ColorMatchingConfiguration
    private var timer: Timer?
    private var duration: Int
    private var currentScore: Int

    private let gradientColors: [[CGColor]] = [[UIColor.stGreenLight.cgColor, UIColor.stGreenDark.cgColor],
                                               [UIColor.stOrangeLight.cgColor, UIColor.stOrangeDark.cgColor],
                                               [UIColor.stIndigoLight.cgColor, UIColor.stIndigoDark.cgColor],
                                               [UIColor.stYellowLight.cgColor, UIColor.stYellowDark.cgColor],
                                               [UIColor.stPinkLight.cgColor, UIColor.stPinkDark.cgColor],
                                               [UIColor.stPurpleLight.cgColor, UIColor.stPurpleDark.cgColor],
                                               [UIColor.stSkyLight.cgColor, UIColor.stSkyDark.cgColor],
                                               [UIColor.stRedLight.cgColor, UIColor.stRedDark.cgColor],
                                               [UIColor.stTurqLight.cgColor, UIColor.stTurqDark.cgColor]]

    private var correctAnswer: [CGColor] = []
    private var firstColumn: [[CGColor]] = []
    private var secondColumn: [[CGColor]] = []
    private var sortedColors: [[CGColor]] = []

    @Published private(set) var state: State?

    init(configuration: ColorMatchingConfiguration) {
        self.configuration = configuration
        duration = configuration.duration
        currentScore = configuration.score
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            generateGradientColors()
            state = .initial(gradientColors: sortedColors)
            state = .timerStarted(duration: timeString(time: TimeInterval(duration)))
            state = .updateScore(score: currentScore)
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timeInterval, repeats: true, block: { [weak self] _ in
                self?.startTimer()
            })
        case let .didTapBlockAt(index):
            validateSelectedBlocks(by: index)
        case .didTapBackButton:
            timer?.invalidate()
            configuration.duration = duration
            configuration.score = currentScore
            state = .configured(configuration: configuration)
        }
    }

    private func startTimer() {
        guard duration != 0 else {
            finishGame()
            return
        }
        duration -= 1
        state = .timerStarted(duration: timeString(time: TimeInterval(duration)))
    }

    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

    private func validateSelectedBlocks(by index: Int) {
        index % 2 == 0 ? validate(by: index, in: firstColumn) : validate(by: index, in: secondColumn)
    }

    private func validate(by index: Int, in array: [[CGColor]]) {
        let gradientColor = array[index / 2]
        guard gradientColor == correctAnswer else { return }
        updateColors()
    }

    private func updateColors() {
        currentScore += 10
        state = .updateScore(score: currentScore)
        generateGradientColors()
        state = .initial(gradientColors: sortedColors)
    }

    // swiftlint:disable all
    private func generateGradientColors() {
        clearColors()
        firstColumn.append(contentsOf: createFirstArray())
        secondColumn.append(contentsOf: createSecondArray())
        sortedColors.append(contentsOf: crossJoinedMerge(arrayF: firstColumn, arrayS: secondColumn))
    }

    private func clearColors() {
        correctAnswer = []
        firstColumn = []
        secondColumn = []
        sortedColors = []
    }

    private func createFirstArray() -> [[CGColor]] {
        var first: [[CGColor]] = []
        while first.count != 5 {
            let gradientColor = gradientColors.randomElement()!
            if !first.contains(gradientColor) {
                first.append(gradientColor)
            }
        }
        return first.shuffled()
    }

    private func createSecondArray() -> [[CGColor]] {
        var second: [[CGColor]] = []
        while second.count != 4 {
            let gradientColor = gradientColors.randomElement()!
            if !firstColumn.contains(gradientColor) {
                if !second.contains(gradientColor) {
                    second.append(gradientColor)
                }
            }
        }

        let exactColor = firstColumn.randomElement()!
        correctAnswer.append(contentsOf: exactColor)
        second.append(exactColor)
        return second.shuffled()
    }

    private func finishGame() {
        timer?.invalidate()
        state = .finished(score: currentScore)
    }

    deinit {
        timer?.invalidate()
    }

    private func crossJoinedMerge<T>(arrayF: [T], arrayS: [T]) -> [T] {
        var i = 0
        var j = 0
        var arrayRes: [T] = []

        while i < arrayF.count, j < arrayS.count {
            arrayRes.append(arrayF[i])
            i += 1
            arrayRes.append(arrayS[j])
            j += 1
        }
        while i < arrayF.count {
            arrayRes.append(arrayF[i])
            i += 1
        }
        while j < arrayS.count {
            arrayRes.append(arrayS[j])
            j += 1
        }
        return arrayRes
    }
}
