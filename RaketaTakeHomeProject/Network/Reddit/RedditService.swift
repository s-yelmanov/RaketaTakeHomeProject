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

    private func getRequest(lastPostID: String?) -> URLRequest? {
        guard let url = URL(string: baseUrlString + "?after=\(lastPostID ?? "")") else {
            return nil
        }

        let request = URLRequest(url: url)

        return request
    }

    func getTopPosts(lastPostID: String?, completionHandler: @escaping (Result<RedditTopResponse, NetworkingError>) -> Void) {
        guard let urlRequest = getRequest(lastPostID: lastPostID) else {
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
