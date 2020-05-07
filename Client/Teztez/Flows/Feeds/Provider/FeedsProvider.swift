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
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        AF.request("http://192.168.1.109:8080/feed").responseDecodable(of: [Block].self, decoder: decoder) { response in
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
