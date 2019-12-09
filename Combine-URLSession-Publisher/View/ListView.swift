//
//  ListView.swift
//  Combine-URLSession-Publisher
//
//  Created by Dmitriy Lupych on 09.12.2019.
//  Copyright © 2019 Dmitry Lupich. All rights reserved.
//

import Foundation
import SwiftUI

struct ListView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.jobs) { job in
            VStack(alignment: .leading) {
                Text("Company: \(job.company)")
                    .font(.headline)
                Text("Position: \(job.title)")
                    .foregroundColor(.gray)
            }.padding(8)
        }.onAppear { self.viewModel.load() }
    }
}
