//
//  ColorMatchingTrainingFacade.swift
//  Teztez
//
//  Created by Adlet on 5/5/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

// swiftlint:disable all
final class ColorMatchingTrainingFacade {
    private let gradientColors: [[CGColor]] = [[UIColor.stGreenLight.cgColor, UIColor.stGreenDark.cgColor],
                                               [UIColor.stOrangeLight.cgColor, UIColor.stOrangeDark.cgColor],
                                               [UIColor.stIndigoLight.cgColor, UIColor.stIndigoDark.cgColor],
                                               [UIColor.stYellowLight.cgColor, UIColor.stYellowDark.cgColor],
                                               [UIColor.stPinkLight.cgColor, UIColor.stPinkDark.cgColor],
                                               [UIColor.stPurpleLight.cgColor, UIColor.stPurpleDark.cgColor],
                                               [UIColor.stSkyLight.cgColor, UIColor.stSkyDark.cgColor],
                                               [UIColor.stRedLight.cgColor, UIColor.stRedDark.cgColor],
                                               [UIColor.stTurqLight.cgColor, UIColor.stTurqDark.cgColor]]

    var rightBlocksGradientColors: [[CGColor]] = []
    var leftBlocksGradientColors: [[CGColor]] = []
    var sortedGradientColors: [[CGColor]] = []
    var correctAnswer: [CGColor] = []

    func generateGradientColors() {
        clearColors()
        rightBlocksGradientColors.append(contentsOf: makeRightBlocksColors())
        leftBlocksGradientColors.append(contentsOf: makeLefttBlocksColors())
        sortedGradientColors.append(contentsOf: makeCrossJoinedMerge(arrayF: rightBlocksGradientColors,
                                                                     arrayS: leftBlocksGradientColors))
    }

    private func clearColors() {
        rightBlocksGradientColors.removeAll()
        leftBlocksGradientColors.removeAll()
        sortedGradientColors.removeAll()
        correctAnswer.removeAll()
    }

    private func makeRightBlocksColors() -> [[CGColor]] {
        var colors: [[CGColor]] = []
        while colors.count != 5 {
            let gradientColor = gradientColors.randomElement()!
            if !colors.contains(gradientColor) {
                colors.append(gradientColor)
            }
        }
        return colors.shuffled()
    }

    private func makeLefttBlocksColors() -> [[CGColor]] {
        var colors: [[CGColor]] = []
        while colors.count != 4 {
            let gradientColor = gradientColors.randomElement()!
            if !rightBlocksGradientColors.contains(gradientColor) {
                if !colors.contains(gradientColor) {
                    colors.append(gradientColor)
                }
            }
        }

        let exactColor = rightBlocksGradientColors.randomElement()!
        correctAnswer.append(contentsOf: exactColor)
        colors.append(exactColor)
        return colors.shuffled()
    }

    private func makeCrossJoinedMerge<T>(arrayF: [T], arrayS: [T]) -> [T] {
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
