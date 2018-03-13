//
//  PhotoServiceTests.swift
//  FlickrTests
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import XCTest
@testable import Flickr

class PhotoServiceTests: XCTestCase {
    func testReturnsFailureWhenNoData() {
        let expectation = XCTestExpectation()

        PhotoService.session.mockData = Data()

        PhotoService.fetch { result in
            switch result {
            case .success(_): XCTFail("😒 PhotoService.fetch call should have failed with no data")
            case .failure(let error): XCTAssertEqual(error, .jsonDecodingError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testTransformsJSONIntoPhotoContainer() {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "PhotoResponseSuccess", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        else {
                XCTFail("😒 NetworkCall was not mocked")
                return
        }

        let expectation = XCTestExpectation()

        PhotoService.session.mockData = data

        PhotoService.fetch { result in
            switch result {
            case .success(let photoContainer):
                XCTAssertEqual(photoContainer.title, "Uploads from everyone")
                XCTAssertEqual(photoContainer.items.count, 20)
                XCTAssertEqual(photoContainer.items[0].media.m, URL(string:"https://farm5.staticflickr.com/4776/25916467797_7905d135b1_m.jpg")!)
            case .failure(_): XCTFail("😎 PhotoService.fetch call should have succeeded with valid data")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
