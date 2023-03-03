//
//  ContentView.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import SwiftUI

struct PeopleView: View {
    
    @StateObject var viewModel: PeopleViewModel
    @State var personDetailComposer: DetailViewComposer
    @State var isShowingDetail = false
    var body: some View {
        NavigationStack {
            VStack {
                if let error = viewModel.error {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding(5)
                    Text(error)
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else if viewModel.PeopleList.count == 0 {
                    ProgressView()
                        .padding(5)
                    Text("Loading")
                        .foregroundColor(.secondary)
                } else {
                    List(viewModel.PeopleList) { person in
                        NavigationLink {
                            personDetailComposer.viewComposedWith(person: person)
                        } label: {
                            Text(person.name)
                                .font(.headline)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadPeople()
            }
            .navigationTitle("Star Wars Characters")
            .navigationViewStyle(.stack)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView(viewModel: PeopleViewModel(feedLoader: RemotePersonLoader(url: URL(string: "https://swapi.dev/api/")!, client: URLSessionHTTPClient(session: .shared))), personDetailComposer: DetailViewComposer(client: URLSessionHTTPClient(session: .shared)))
    }
}
