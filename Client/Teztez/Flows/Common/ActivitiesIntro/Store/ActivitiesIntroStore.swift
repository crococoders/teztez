//
//  ActivitiesIntroStore.swift
//  Teztez
//
//  Created by Adlet on 4/23/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

// TODO: - Remove
struct ActivitiesIntro {
    let title: String
    let image: String
    let infoTitle: String
    let infoDescr: String
    let infoImage: String
    let usageTitle: String
    let usageDescr: String
    let usageImage: String
}

// swiftlint:disable all
final class ActivitiesIntroStore {
    enum Action {
        case didLoadView
    }

    enum State {
        case update(activitiesIntro: ActivitiesIntro)
    }

    @Observable var state: State?

    func dispatch(action: Action) {
        switch action {
        case .didLoadView:
            let data = ActivitiesIntro(title: "Backwards",
                                       image: "backwards-title-icon",
                                       infoTitle: "What is the Backwards?",
                                       infoDescr: "Backwards is one type of training which will help to increase your reading speed. One of the popular game to improve your word uderstaing of brain",
                                       infoImage: "backwards-how-icon",
                                       usageTitle: "How to Play?",
                                       usageDescr: "You should read text then convert it. Spread will flip every word. After the time your brain will build words by letters even they are not correct.",
                                       usageImage: "backwards-what-icon")
            
            state = .update(activitiesIntro: data)
        }
    }
}
