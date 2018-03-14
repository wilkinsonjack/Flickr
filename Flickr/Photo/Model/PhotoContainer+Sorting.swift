//
//  PhotoContainer+Sorting.swift
//  Flickr
//
//  Created by Jack Wilkinson on 14/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import Foundation

extension PhotoContainer {
    func sorted(by type: PhotoSortType) -> PhotoContainer {
        let items = self.items.sorted(by: type)
        let container = PhotoContainer(title: self.title,
                                       link: self.link,
                                       description: self.description,
                                       modified: self.modified,
                                       generator: self.generator,
                                       items: items)
        return container
    }
}

extension Array where Element == PhotoContainer.Item {
    func sorted(by sortType: PhotoSortType) -> [PhotoContainer.Item]  {
        switch sortType {
        case .datePublished:
            return self.sorted { $0.published > $1.published }
        case .dateTaken:
            return self.sorted { $0.dateTaken > $1.dateTaken }
        }
    }
}
