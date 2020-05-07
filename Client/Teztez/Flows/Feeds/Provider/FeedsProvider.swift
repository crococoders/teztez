//
//  FeedsProvider.swift
//  Teztez
//
//  Created by Almas Zainoldin on 5/7/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Alamofire
import Foundation

final class FeedsProvider {
    func fetchFeeds(callback: @escaping (Result<[Block], Error>) -> Void) {
        AF.request("http://localhost:8080/feed").responseJSON { reponse in
            switch reponse.result {
            case .success:
                guard let data = reponse.data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .millisecondsSince1970
                    let blocks = try decoder.decode([Block].self, from: data)
                    callback(.success(blocks))
                } catch {
                    callback(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
                callback(.failure(error))
            }
        }
    }
}
