//
//  PeopleDetail.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import SwiftUI

struct PeopleDetail: View {
    @State var person: Person
    @StateObject var viewModel: PeopleDetailViewModel
    var filmViewComposer: FilmViewComposer
    var body: some View {
        ScrollView {
            VStack {
                Text("Name")
                    .font(.title)
                Text(person.name)
                Text(person.dateOfBirth)
                
                ForEach(person.films) { filmURL in
                    filmViewComposer.viewComposedWith(url: filmURL.url)
                        .padding(.bottom)
                }
            }
        }
        
        
    }
}


