//
//  FilmView.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-02.
//

import SwiftUI

struct FilmView: View {
    @StateObject var viewModel: FilmViewModel
    
    var body: some View {
        HStack {
            VStack {
                if viewModel.isLoading {
                    Text("Film name redacted")
                        .font(.title2)
                        .redacted(reason: .placeholder)
                        .shimmering()
                    Text("Opening Crawl Word count: \(viewModel.words)")
                        .font(.caption)
                        .redacted(reason: .placeholder)
                        .shimmering()
                } else if !viewModel.isLoading && viewModel.error == nil {
                    Text(viewModel.name)
                        .font(.title2)
                    Text("Opening Crawl word count: \(viewModel.words)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else if let error = viewModel.error {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                            .padding(5)
                        Text(error)
                            .multilineTextAlignment(.center)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
