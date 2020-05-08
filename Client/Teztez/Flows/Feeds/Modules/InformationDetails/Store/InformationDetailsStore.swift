//
//  InformationDetailsStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 08/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Foundation

final class InformationDetailsStore {
    enum Action {}
    enum State {
        case initial(title: String, metaTitle: String, imageURL: URL?)
    }

    @Published private(set) var state: State?

    init(details: InformationDetails) {
        state = .initial(title: details.title, metaTitle: details.metaTitle, imageURL: URL(string: details.imageURL))
    }

    func dispatch(action: Action) {}
}
