//
//  PhotoContainerItemTests.swift
//  FlickrTests
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import XCTest
@testable import Flickr

class PhotoContainerItemTests: XCTestCase {
    func testSharedFromReturnsValidUsername() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "PhotoItemResponseSuccess", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
              let item = try? JSONDecoder().decode(PhotoContainer.Item.self, from: data)
        else {
            return
        }

        XCTAssertEqual(item.author, "nobody@flickr.com (\"hej74458\")")
        XCTAssertEqual(item.username, "hej74458")
    }

    func testSharedFromReturnsDefaultString() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "PhotoItemResponseMalformed", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let item = try? JSONDecoder().decode(PhotoContainer.Item.self, from: data)
            else {
                return
        }

        XCTAssertEqual(item.username, "A Flickr user")
    }
}
