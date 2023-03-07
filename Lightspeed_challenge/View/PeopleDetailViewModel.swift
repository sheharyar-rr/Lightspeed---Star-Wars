//
//  PeopleDetailViewModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation
import Lightspeed

class PeopleDetailViewModel: ObservableObject {
    @Published var film: [Film] = []
    private var person: Person
    
    init(person: Person) {
        self.person = person
    }
    
    
    
    
}
