//
//  PeopleViewModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

class PeopleViewModel: ObservableObject {
    @Published var PeopleList: [Person] = []
    
    private let feedLoader: FeedLoader
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    func loadPeople() {
        feedLoader.load {[weak self] result in
            DispatchQueue.main.async {
                if let people = try? result.get() {
                    self?.PeopleList = people.sorted(by: {
                        $0.name < $1.name
                    })
                } else {
                    
                }
            }
        }
    }
    
}
