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
    private var cancellBag = Set<AnyCancellable>()
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    private let url = URL(string: "https://jobs.github.com/positions.json?description=swift")!
    @Published public var jobs = [JobModel]()

    func load() {
        let request = URLRequest(url: url)
        session.dataResponse(for: request)
            .decode(type: [JobModel].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { (error) in
                //TODO: - Handle Error
                print(error)
            }) { (jobs) in
                self.jobs = jobs
        }.store(in: &cancellBag)
    }
}
