//
//  SuggestActivityStore.swift
//  Teztez
//
//  Created by Almas Zainoldin on 05/05/2020.
//  Copyright © 2020 Crococoders. All rights reserved.
//

import Alamofire
import Foundation

final class SuggestActivityStore {
    enum Action {
        case didSendFeedback(title: String, feedback: String)
        case didStartTextChange
        case didResetText
    }

    enum State {
        case reset
        case textChanging
        case sended
    }

    @Published private(set) var state: State?

    func dispatch(action: Action) {
        switch action {
        case let .didSendFeedback(title, text):
            send(title: title, feedback: text)
        case .didStartTextChange:
            state = .textChanging
        case .didResetText:
            state = .reset
        }
    }

    private func send(title: String, feedback: String) {
        guard let token = UserSession.shared.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
                                    "Accept": "application/json"]
        let params: Parameters = ["title": title,
                                  "text": feedback,
                                  "gameTitle": "Suggestion"]
        AF.request("http://159.65.155.64:8080/feedback", method: .post, parameters: params, headers: headers).response { data in
            switch data.result {
            case .success:
                print("Sended")
            case let .failure(error):
                print("Failure with error \(error)")
            }
        }
        state = .sended
    }
}
