//
//  PersonalCoachTrainingViewController.swift
//  Teztez
//
//  Created by Almas Zainoldin on 02/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Combine
import UIKit

protocol PersonalCoachTrainingPresentable: Presentable {
    var onBackButtonDidTap: ((_ currentWordIndex: Int) -> Void)? { get set }
    var onTrainingDidFinish: ((_ speed: Int) -> Void)? { get set }
}

final class PersonalCoachTrainingViewController: ViewController, PersonalCoachTrainingPresentable {
    var onBackButtonDidTap: ((_ currentWordIndex: Int) -> Void)?
    var onTrainingDidFinish: ((_ speed: Int) -> Void)?

    private let store: PersonalCoachTrainingStore
    private var cancellables = Set<AnyCancellable>()
    @IBOutlet private var messageLabel: UILabel!
    // TODO: Rename this label
    @IBOutlet private var changeableLabel: UILabel!

    init(store: PersonalCoachTrainingStore) {
        self.store = store
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        store.dispatch(action: .didLoadView)
    }

    private func setupObservers() {
        store.$state.sink { [weak self] state in
            guard
                let self = self,
                let state = state else { return }
            switch state {
            case let .timerUpdated(second):
                self.changeableLabel.text = second
            case let .trainingStarted(speed):
                self.messageLabel.text = speed
                self.changeableLabel.font = .displayBold48
            case let .wordUpdated(word):
                self.changeableLabel.text = word
            case let .finished(speed):
                self.onTrainingDidFinish?(speed)
            case let .paused(currentWordIndex):
                self.onBackButtonDidTap?(currentWordIndex)
            }
        }.store(in: &cancellables)
    }

    override func customBackButtonDidTap() {
        store.dispatch(action: .didTapBackButton)
    }

    override func transitionBackDidFinish() {
        // TODO: add logic to save currentWordIndex
    }
}
