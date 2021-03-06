//
//  NetworkError.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

enum NetworkingError: String, Error {

    case invalidUrl = "Invalid URL"
    case invalidRequest = "Invalid request"
    case invalidResponse = "Invalid response"
    case noInternet = "No internet connection"

}

extension NetworkingError: LocalizedError {

    var errorDescription: String? {
        NSLocalizedString(rawValue, comment: "")
    }

}
