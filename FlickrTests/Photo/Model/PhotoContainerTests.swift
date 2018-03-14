//
//  PhotoContainerTests.swift
//  FlickrTests
//
//  Created by Jack Wilkinson on 14/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import XCTest
@testable import Flickr

class PhotoContainerTests: XCTestCase {
    let oldDate = Date(timeIntervalSince1970: 10)
    let newerDate = Date(timeIntervalSince1970: 23432)

    func testPhotoContainerIsSortedByPublishedInDescendingOrder() {
        let items: [PhotoContainer.Item] = [
            PhotoContainer.Item(title: "Oldest Published",
                                link: URL(string: "https://google.com")!,
                                media: PhotoContainer.Item.Media(url: URL(string: "https://google.com")!),
                                dateTaken: oldDate,
                                description: "test",
                                published: oldDate,
                                author: "test",
                                authorID: "test",
                                tags: "test"),
            PhotoContainer.Item(title: "Newest Published",
                                link: URL(string: "https://google.com")!,
                                media: PhotoContainer.Item.Media(url: URL(string: "https://google.com")!),
                                dateTaken: newerDate,
                                description: "test",
                                published: newerDate,
                                author: "test",
                                authorID: "test",
                                tags: "test"),
        ]

        let photoContainer = PhotoContainer(title: "Test",
                                            link: URL(string: "https://google.com")!,
                                            description: "Test",
                                            modified: "Test",
                                            generator: "Test",
                                            items: items)

        XCTAssertEqual(photoContainer.items[0].title, "Oldest Published")
        XCTAssertEqual(photoContainer.items[0].published, oldDate)

        let sortedPhotoContainer = photoContainer.sorted(by: .datePublished)
        XCTAssertEqual(sortedPhotoContainer.items[0].title, "Newest Published")
        XCTAssertEqual(sortedPhotoContainer.items[0].published, newerDate)
    }

    func testPhotoContainerIsSortedByDateTakenInDescendingOrder() {
        let items: [PhotoContainer.Item] = [
            PhotoContainer.Item(title: "Oldest Date Taken",
                                link: URL(string: "https://google.com")!,
                                media: PhotoContainer.Item.Media(url: URL(string: "https://google.com")!),
                                dateTaken: oldDate,
                                description: "test",
                                published: oldDate,
                                author: "test",
                                authorID: "test",
                                tags: "test"),
            PhotoContainer.Item(title: "Newest Date Taken",
                                link: URL(string: "https://google.com")!,
                                media: PhotoContainer.Item.Media(url: URL(string: "https://google.com")!),
                                dateTaken: newerDate,
                                description: "test",
                                published: newerDate,
                                author: "test",
                                authorID: "test",
                                tags: "test"),
            ]

        let photoContainer = PhotoContainer(title: "Test",
                                            link: URL(string: "https://google.com")!,
                                            description: "Test",
                                            modified: "Test",
                                            generator: "Test",
                                            items: items)

        XCTAssertEqual(photoContainer.items[0].title, "Oldest Date Taken")
        XCTAssertEqual(photoContainer.items[0].dateTaken, oldDate)

        let sortedPhotoContainer = photoContainer.sorted(by: .dateTaken)
        XCTAssertEqual(sortedPhotoContainer.items[0].title, "Newest Date Taken")
        XCTAssertEqual(sortedPhotoContainer.items[0].dateTaken, newerDate)
    }
}
