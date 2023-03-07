//
//  PeopleViewTests+LoaderSpy.swift
//  Lightspeed_challengeTests
//
//  Created by Sheharyar Irfan on 2023-03-06.
//

import Foundation
import Lightspeed

extension PeopleViewTests {
    
    class LoaderSpy: PersonFeedLoader {
        
        private var feedRequests = [(PersonFeedLoader.Result) -> Void]()
        
        var loadFeedCallCount: Int {
            return feedRequests.count
        }
        
        func load(completion: @escaping (PersonFeedLoader.Result) -> Void) {
            feedRequests.append(completion)
        }
        
        func completeFeedLoading(with feed: [Person] = [], at index: Int = 0) {
            feedRequests[index](.success(feed))
        }
        
        func completeFeedLoadingWithError(at index: Int = 0) {
            let error = NSError(domain: "an error", code: 0)
            feedRequests[index](.failure(error))
        }
        
    }
    
}
