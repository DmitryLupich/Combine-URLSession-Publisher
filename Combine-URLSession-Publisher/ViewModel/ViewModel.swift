//
//  ViewModel.swift
//  Combine-URLSession-Publisher
//
//  Created by Dmitriy Lupych on 09.12.2019.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    private let url = URL(string: "https://jobs.github.com/positions.json?description=swift")!
    @Published public var jobs = [JobModel]()

    func load() {
        let request = URLRequest(url: url)
        _ = session.dataResponse(for: request)
            .decode(type: [JobModel].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { (error) in
                print(error)
            }) { (jobs) in
                print(jobs)
                self.jobs = jobs
        }
    }
}
