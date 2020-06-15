//
//  RedditTopResponse.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 13.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Foundation

struct RedditTopResponse: Codable {
    let data: RedditTopDataResponse
}

struct RedditTopDataResponse: Codable {
    let children: [RedditTopDataChildrenResponse]
    let after: String?
}

struct RedditTopDataChildrenResponse: Codable {
    let data: RedditTopItemResponse
}

struct RedditTopItemResponse: Codable {

    let title: String
    let author: String
    let thumbnail: String?
    let preview: RedditTopItemPreviewResponse?
    let created: Int
    let numberOfComments: Int

    private enum CodingKeys: String, CodingKey {
        case title, author, thumbnail, preview, created, numberOfComments = "num_comments"
    }

    var timeString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(created))
        return date.timeAgoSinceDate()
    }

    var additionalImage: String? {
        preview?.images.first?.source.url?.htmlDecoded
    }

}

struct RedditTopItemPreviewResponse: Codable {
    let images: [RedditTopItemImageResponse]
}

struct RedditTopItemImageResponse: Codable {
    let source: RedditTopItemImageSourceResponse
}

struct RedditTopItemImageSourceResponse: Codable {
    let url: String?
}
