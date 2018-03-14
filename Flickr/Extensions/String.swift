//
//  String.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import Foundation

extension String {
    func firstMatch(from pattern: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: self, range: NSRange(location: 0, length: self.count))
        else { return nil }

        return (self as NSString).substring(with: match.range(at:1))
    }
}

