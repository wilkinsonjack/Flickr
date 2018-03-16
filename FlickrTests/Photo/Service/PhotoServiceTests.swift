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
    override func setUp() {
        super.setUp()
        PhotoService.session.mockData = nil
        PhotoService.session.mockError = nil
        PhotoService.session.mockResponse = nil
    }

    func testReturnsFailureWhenInvalidData() {
        let expectation = XCTestExpectation()

        PhotoService.session.mockData = Data()

        PhotoService.fetch { result in
            switch result {
            case .success(_): XCTFail("😒 PhotoService.fetch call should have failed with invalid data")
            case .failure(let error): XCTAssertEqual(error, .jsonDecodingError)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testReturnsFailureWhenErrorInAPICall() {
        let expectation = XCTestExpectation()

        PhotoService.session.mockError = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: [:])

        PhotoService.fetch { result in
            switch result {
            case .success(_): XCTFail("😒 PhotoService.fetch call should have failed with timeout error")
            case .failure(let error): XCTAssertEqual(error, .serviceError)
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
                XCTAssertEqual(photoContainer.items[0].media.url, URL(string:"https://farm5.staticflickr.com/4776/25916467797_7905d135b1_m.jpg")!)
            case .failure(_):
                XCTFail("😎 PhotoService.fetch call should have succeeded with valid data")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testServiceErrorPrettyMessageReturnsSameRegardlessOfError() {
        let expectedString = "Some thing has gone wrong"

        let jsonError = PhotoService.ServiceError.jsonDecodingError
        let serviceError = PhotoService.ServiceError.serviceError

        XCTAssertEqual(jsonError.prettyError, expectedString)
        XCTAssertEqual(serviceError.prettyError, expectedString)
    }
}
