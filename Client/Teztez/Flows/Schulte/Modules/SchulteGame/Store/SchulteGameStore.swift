//
//  SchulteGameStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 03/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class SchulteGameStore {
    enum Action {
        case didLoadView
        case didSelectItemAt(index: Int)
    }

    enum State {
        case initial(numbers: [Int])
        case nextNumberUpdated(number: Int)
    }

    private let configuration: SchulteConfiguration
    private var currentNumber: Int = 1
    private var numbers: [Int] = []

    @Published private(set) var state: State?

    init(configuration: SchulteConfiguration) {
        self.configuration = configuration
        generateInitialNumbers()
    }

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            state = .initial(numbers: numbers)
        case let .didSelectItemAt(index):
            validate(with: numbers[index])
        }
    }

    private func generateInitialNumbers() {
        for number in 1 ... 25 {
            numbers.append(number)
        }
    }

    private func validate(with number: Int) {
        guard currentNumber != 25 else { return }
        if currentNumber == number {
            currentNumber += 1
            state = .nextNumberUpdated(number: currentNumber)
        } else {}
    }
}
