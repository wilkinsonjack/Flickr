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
    let modified: String
    let generator: String
    let items: [Item]

    enum CodingKeys: String, CodingKey {
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
        let dateTaken: String
        let description: String
        let published: String
        let author: String
        let authorID: String
        let tags: String
        
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
            let m: URL

            enum CodingKeys: String, CodingKey {
                case m
            }
        }
    }
}

extension PhotoContainer.Item {
    var username: String {
        let pattern = "\"([^\"]+)\""

        return author.firstMatch(from: pattern) ?? "A Flickr user"
    }
}


