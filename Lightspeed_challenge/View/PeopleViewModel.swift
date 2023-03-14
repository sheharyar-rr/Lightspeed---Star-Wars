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
    @Published var hasNext = false
    
    private let feedLoader: PersonFeedLoader
    init(feedLoader: PersonFeedLoader) {
        self.feedLoader = feedLoader
    }
    
    public func loadPeople(next: Bool = false) {
        print("Load people: \(next)")
        isShowingLoading = (true && !next)
        feedLoader.load(next: next) {[weak self] result in
            DispatchQueue.main.async {
                self?.isShowingLoading = false
                switch result {
                case .failure(let error):
                    print("Loading error",error.localizedDescription)
                    self?.error = error.localizedDescription
                case .success((let people, let hasNext)):
                    self?.hasNext = hasNext
                    if next {
                        if let currentPeopleList = self?.PeopleList {
                            var newList:[Person] = []
                            newList.append(contentsOf: currentPeopleList)
                            newList.append(contentsOf: people)
                            let uniqueList = Array(Set(newList))
                            self?.PeopleList = uniqueList.sorted(by: { $0.name < $1.name })
                            self?.error = nil
                        }
                    } else {
                        self?.PeopleList = people.sorted(by: {
                            $0.name < $1.name
                        })
                    }
                }
            }
        }
    }
    
}
