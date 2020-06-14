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
}

struct RedditTopDataChildrenResponse: Codable {
    let data: RedditTopItemResponse
}

struct RedditTopItemResponse: Codable {

    let title: String
    let author: String
    let thumbnail: String?
    let url: String?
    let created: Int
    let numberOfComments: Int

    private enum CodingKeys: String, CodingKey {
        case title, author, thumbnail, url, created, numberOfComments = "num_comments"
    }

    var timeString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(created))
        return date.timeAgoSinceDate()
    }

}

struct RedditTopItemPreviewResponse:Codable {
    let images: [RedditTopItemImageResponse]
}

struct RedditTopItemImageResponse: Codable {
    let source: RedditTopItemImageSourceResponse

}

struct RedditTopItemImageSourceResponse: Codable {
    let url: String?
}
