//
//  PeopleDetailViewModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

class PeopleDetailViewModel: ObservableObject {
    @Published var film: Film?
    
    private var detailLoader: RemoteFilmLoader
    private var person: Person
    
    init(detailLoader: RemoteFilmLoader, person: Person) {
        self.detailLoader = detailLoader
        self.person = person
    }
    
    func loadDetails() {
        print("ViewModel load details")
        detailLoader.load { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let film):
                    self.film = film
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
}
