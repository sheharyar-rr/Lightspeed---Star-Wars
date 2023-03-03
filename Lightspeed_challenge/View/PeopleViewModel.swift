//
//  PeopleViewModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

class PeopleViewModel: ObservableObject {
    @Published var PeopleList: [Person] = []
    @Published var error: String?
    
    private let feedLoader: FeedLoader
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    func loadPeople() {
        feedLoader.load {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Here 3",error.localizedDescription)
                   // self?.error = error.localizedDescription
                case .success(let people):
                    self?.PeopleList = people.sorted(by: {
                        $0.name < $1.name
                    })
                }
            }
        }
    }
    
}
