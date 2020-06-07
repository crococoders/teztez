//
//  FeedsProvider.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/7/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Alamofire
import Foundation
import Models

final class FeedsProvider {
    func fetchFeeds(callback: @escaping (Result<[Block], Error>) -> Void) {
        guard
            let token = UserSession.shared.token,
            let userId = UserSession.shared.userId else { return }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
                                    "Accept": "application/json"]
        AF.request("http://159.65.155.64:8080/feed/\(userId)", headers: headers).responseDecodable(of: [Block].self, decoder: decoder) { response in
            switch response.result {
            case let .success(blocks):
                callback(.success(blocks))
            case let .failure(error):
                print(error.localizedDescription)
                callback(.failure(error))
            }
        }
    }
}
