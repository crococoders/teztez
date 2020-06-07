//
//  AnalyticsProvider.swift
//  Teztez
//
//  Created by Adlet on 5/9/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Alamofire
import UIKit

// TODO: - refactor
final class AnalyticsProvider {
    static let shared = AnalyticsProvider()

    private init() {}

    func postAnalytcis(events: [AnalyticsEvent]) {
        let body: [String: [AnalyticsEvent]] = ["events": events]

        guard let token = UserSession.shared.token else { return }
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        AF.request("http://159.65.155.64::8080/analytics",
                   method: .post,
                   parameters: body,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseJSON { response in
            switch response.result {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
