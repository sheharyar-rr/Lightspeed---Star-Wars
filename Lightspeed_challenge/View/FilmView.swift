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
        VStack {
            Text("Film")
                .font(.title)
            Text(viewModel.name)
            Text("Opening Crawl")
                .font(.title)
            Text(viewModel.openingCrawl)
            
        }
        
    }
}
//
//struct FilmView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilmView()
//    }
//}
