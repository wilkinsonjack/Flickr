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
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()

    func testSharedFromReturnsValidUsername() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "PhotoItemResponseSuccess", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
              let item = try? decoder.decode(PhotoContainer.Item.self, from: data)
        else {
            XCTFail("😒 PhotoContainer.Item was not decoded from JSON")
            return
        }

        XCTAssertEqual(item.author, "nobody@flickr.com (\"hej74458\")")
        XCTAssertEqual(item.username, "hej74458")
    }

    func testSharedFromReturnsDefaultString() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "PhotoItemResponseMalformed", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
            let item = try? decoder.decode(PhotoContainer.Item.self, from: data)
        else {
            XCTFail("😒 PhotoContainer.Item was not decoded from JSON")
            return
        }

        XCTAssertEqual(item.username, "A Flickr user")
    }
}
