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
                } else {
                    Text(viewModel.name)
                        .font(.title2)
                }
                if viewModel.isLoading {
                    Text("Opening Crawl Word count: \(viewModel.words)")
                        .font(.caption)
                        .redacted(reason: .placeholder)
                        .shimmering()
                } else {
                    Text("Opening Crawl word count: \(viewModel.words)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                
            }
        }
        
        
    }
}
