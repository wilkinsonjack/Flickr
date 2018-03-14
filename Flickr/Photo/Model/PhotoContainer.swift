//
//  PhotoContainer.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import Foundation

struct PhotoContainer: Codable {
    let title: String
    let link: URL
    let description: String
    let modified: Date
    let generator: String
    let items: [Item]

    enum CodingKeys: CodingKey {
        case title
        case link
        case description
        case modified
        case generator
        case items
    }

    struct Item: Codable {
        let title: String
        let link: URL
        let media: Media
        let dateTaken: Date
        let description: String
        let published: Date
        let author: String
        let authorID: String
        let tags: String

        var username: String {
            let pattern = "\"([^\"]+)\""
            return author.firstMatch(from: pattern) ?? "A Flickr user"
        }

        enum CodingKeys: String, CodingKey {
            case title
            case link
            case media
            case dateTaken = "date_taken"
            case description
            case published
            case author
            case authorID = "author_id"
            case tags
        }


        struct Media: Codable {
            let url: URL

            enum CodingKeys: String, CodingKey {
                case url = "m"
            }
        }
    }
}

