//
//  RedditService.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

final class RedditService {

    private let baseUrlString = "https://www.reddit.com/top.json"

    init() {}

    private func getRequest() -> URLRequest? {
        guard let url = URL(string: baseUrlString) else {
            return nil
        }

        let request = URLRequest(url: url)

        return request
    }

    func getTopPosts(completionHandler: @escaping (Result<RedditTopResponse, NetworkingError>) -> Void) {
        guard let urlRequest = getRequest() else {
            completionHandler(.failure(.invalidUrl))
            return
        }

        NetworkService.shared.fetchData(with: urlRequest) { (response: Result<RedditTopResponse, NetworkingError>) in
            switch response {
            case .success(let response):
                completionHandler(.success(response))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}
