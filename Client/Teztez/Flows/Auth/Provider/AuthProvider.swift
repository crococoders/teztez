//
//  AuthProvider.swift
//  Teztez
//
//  Created by Adlet on 5/8/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Alamofire
import Foundation
import Models

final class AuthProvider {
    func register(viewModel: UserViewModel,
                  callback: @escaping (Result<UserResponse, Error>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let params: [String: Any] = ["name": viewModel.name,
                                     "username": viewModel.userName,
                                     "password": viewModel.password,
                                     "confirmPassword": viewModel.confirmPassword]

        AF.request("http://localhost:8080/auth/register", method: .post, parameters: params)
            .responseDecodable(of: UserResponse.self, decoder: decoder) { response in

                switch response.result {
                case let .success(user):
                    callback(.success(user))
                case let .failure(error):
                    callback(.failure(error))
                }
            }
    }

    func login(username: String, password: String,
               callback: @escaping (Result<TokenResponse, Error>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let headers: HTTPHeaders = [.authorization(username: username, password: password)]

        AF.request("http://localhost:8080/auth/login", method: .post, headers: headers)
            .responseDecodable(of: TokenResponse.self, decoder: decoder) { response in
                switch response.result {
                case let .success(token):
                    callback(.success(token))
                case let .failure(error):
                    callback(.failure(error))
                }
            }
    }
}
