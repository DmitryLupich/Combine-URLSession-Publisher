//
//  Publishers+Extensions.swift
//  Combine-URLSession-Publisher
//
//  Created by Dmitriy Lupych on 09.12.2019.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Combine
import Foundation

// MARK: - Data Publisher

extension Publishers {
    
    struct DataPublisher: Publisher {
        typealias Output = Data
        typealias Failure = Error
        
        private let urlRequest: URLRequest
        
        init(urlRequest: URLRequest) {
            self.urlRequest = urlRequest
        }
        
        func receive<S: Subscriber>(subscriber: S) where
            DataPublisher.Failure == S.Failure, DataPublisher.Output == S.Input {
                let subscription = DataSubscription(request: urlRequest,
                                                    subscriber: subscriber)
                subscriber.receive(subscription: subscription)
        }
    }
}

// MARK: - Data Subscription

extension Publishers {
    
    class DataSubscription<S: Subscriber>: Subscription where S.Input == Data, S.Failure == Error {
        private let session = URLSession.shared
        private let request: URLRequest
        private var subscriber: S?
        
        init(request: URLRequest, subscriber: S) {
            self.request = request
            self.subscriber = subscriber
            sendRequest()
        }
        
        func request(_ demand: Subscribers.Demand) {
            //TODO: - Optionaly Adjust The Demand
        }
        
        func cancel() {
            subscriber = nil
        }
        
        private func sendRequest() {
            guard let subscriber = subscriber else { return }
            session.dataTask(with: request) { (data, _, error) in
                _ = data.map(subscriber.receive)
                _ = error.map { subscriber.receive(completion: Subscribers.Completion.failure($0)) }
            }.resume()
        }
    }
}
