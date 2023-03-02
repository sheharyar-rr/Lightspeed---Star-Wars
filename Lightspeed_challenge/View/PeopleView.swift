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
    var body: some View {
        NavigationView {
            VStack {
                
                List(viewModel.PeopleList) { person in
                    NavigationLink {
                        personDetailComposer.viewComposedWith(person: person)
                    } label: {
                        Text(person.name)
                    }
                    
                }
                
            }
            .onAppear {
                viewModel.loadPeople()
            }
            .navigationTitle("Star Wars")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeopleView(viewModel: PeopleViewModel(feedLoader: RemotePersonLoader(url: URL(string: "https://swapi.dev/api/")!, client: URLSessionHTTPClient(session: .shared))))
//    }
//}
