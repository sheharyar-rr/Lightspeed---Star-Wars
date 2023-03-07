//
//  PeopleDetail.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import SwiftUI
import Lightspeed

struct PeopleDetail: View {
    @State var person: Person
    var filmViewComposer: FilmViewComposer
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                VStack {
                    Text("DOB")
                        .font(.title)
                        .fontDesign(.rounded)
                    Text(person.dateOfBirth)
                        .padding(.bottom)
                        .foregroundColor(.secondary)
                    Text("Physical Attributes")
                        .font(.title)
                        .fontDesign(.rounded)
                    ForEach(person.physicalAttributes) { physicalAttribute in
                        HStack {
                            Text(physicalAttribute.attribute)
                            Text(":")
                            Text(physicalAttribute.value)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Text("Films")
                        .font(.title)
                        .padding(.top)
                    ForEach(person.films) { filmURL in
                        filmViewComposer.viewComposedWith(url: filmURL.url)
                            .padding(.bottom)
                    }
                    .padding(.bottom)
                }
                Spacer()
            }
        }
        .scrollIndicators(.hidden, axes: [.vertical, .horizontal])
        .navigationTitle(person.name)
    }
}


