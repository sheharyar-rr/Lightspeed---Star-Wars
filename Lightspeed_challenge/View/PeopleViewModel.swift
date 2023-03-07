//
//  PeopleViewModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation
import Lightspeed

public class PeopleViewModel: ObservableObject {
    @Published var PeopleList: [Person] = []
    @Published var error: String?
    @Published var isShowingLoading = false
    
    private let feedLoader: PersonFeedLoader
    init(feedLoader: PersonFeedLoader) {
        self.feedLoader = feedLoader
    }
    
    public func loadPeople() {
        isShowingLoading = true
        feedLoader.load {[weak self] result in
            self?.isShowingLoading = false
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Loading error",error.localizedDescription)
                case .success(let people):
                    self?.PeopleList = people.sorted(by: {
                        $0.name < $1.name
                    })
                }
            }
        }
    }
    
}
