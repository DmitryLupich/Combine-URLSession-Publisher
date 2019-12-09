//
//  URLSession+Extensions.swift
//  Combine-URLSession-Publisher
//
//  Created by Dmitriy Lupych on 09.12.2019.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Combine
import Foundation

// MARK: - URLSession Data Publisher

extension URLSession {
    func dataResponse(for request: URLRequest) -> Publishers.DataPublisher {
        return Publishers.DataPublisher(urlRequest: request)
    }
}
