//
//  NetworkSession.swift
//  Flickr
//
//  Created by Jack Wilkinson on 13/03/2018.
//  Copyright © 2018 Jack Wilkinson. All rights reserved.
//

import Foundation

class NetworkSession {
    public let session: URLSession = .shared

    #if DEBUG

    public var mockData: Data?
    public var mockResponse: URLResponse?
    public var mockError: Error?

    public var willRequest: ((URL) -> ())?

    func request(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        willRequest?(url)

        guard mockData == nil,
            mockResponse == nil,
            mockError == nil
        else {
            completion(mockData, mockResponse, mockError)
            return
        }

        session.dataTask(with: url, completionHandler: completion).resume()
    }

    #else

    func request(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        session.dataTask(with: url, completionHandler: completion).resume()
    }

    #endif
}
