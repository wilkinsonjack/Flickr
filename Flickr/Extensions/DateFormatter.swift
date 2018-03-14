//
//  DateFormatter.swift
//  Flickr
//
//  Created by Jack Wilkinson on 14/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let ddMMyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_GB_POSIX")
        return formatter
    }()

    static let ddMMyyyyHHmm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_GB_POSIX")
        return formatter
    }()
}
