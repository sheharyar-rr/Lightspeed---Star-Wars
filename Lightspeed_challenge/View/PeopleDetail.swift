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
    
    var body: some View {
        VStack {
            
            Text("Name")
                .font(.title)
            Text(person.name)
            Text(person.dateOfBirth)
            Text("Films")
                .font(.title)
            
            Text(viewModel.film?.name ?? "NO film")
                .redacted(reason: .placeholder)
                .shimmering()
            Text(viewModel.film?.name ?? "NO film")
                .shimmering()
            Text(viewModel.film?.name ?? "NO film")
                .shimmering()
            Text(viewModel.film?.name ?? "NO film")
                .shimmering()
            
            Spacer()
        }
        .onAppear {
            viewModel.loadDetails()
        }
        
    }
}


