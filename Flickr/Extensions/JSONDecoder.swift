//
//  JSONDecoder.swift
//  Flickr
//
//  Created by Jack Wilkinson on 15/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import Foundation

extension JSONDecoder {
    static let iso6801: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()
}
