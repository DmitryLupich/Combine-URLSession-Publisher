//
//  JobModel.swift
//  Combine-URLSession-Publisher
//
//  Created by Dmitriy Lupych on 09.12.2019.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation

struct JobModel: Identifiable {
    typealias ID = String
    let id: String
    let company: String
    let title: String
}

extension JobModel: Codable { }
