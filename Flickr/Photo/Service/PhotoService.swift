//
//  PhotoService.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import Foundation

struct PhotoService {
    enum ServiceError {
        case jsonDecodingError
    }

    enum PhotoResult {
        case success(PhotoContainer)
        case failure(ServiceError)
    }

    static let session = NetworkSession()

    static func fetch(handle: @escaping (PhotoResult) -> ()) {
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")!
        session.request(url: url) { data, response, error in
            guard let data = data,
                  let photoContainer = try? JSONDecoder.iso6801.decode(PhotoContainer.self, from: data)
            else { return handle(.failure(.jsonDecodingError)) }

            handle(.success(photoContainer))
        }
    }
}
