//
//  DateFormatterTests.swift
//  FlickrTests
//
//  Created by Jack Wilkinson on 14/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import XCTest
@testable import Flickr

class DateFormatterTests: XCTestCase {
    func testddMMyyyyFormatsDateCorrectly() {
        let date = Date(timeIntervalSince1970: 0)
        let string = DateFormatter.ddMMyyyy.string(from: date)
        XCTAssertEqual(string, "01-01-1970")
    }

    func testddMMyyyyHHmmFormatsDateCorrectly() {
        let date = Date(timeIntervalSince1970: 0)
        let string = DateFormatter.ddMMyyyyHHmm.string(from: date)
        XCTAssertEqual(string, "01-01-1970 00:00")
    }
}
