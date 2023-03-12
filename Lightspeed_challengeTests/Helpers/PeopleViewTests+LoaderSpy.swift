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
        
        func load(next: Bool, completion: @escaping (PersonFeedLoader.Result) -> Void) {
            feedRequests.append(completion)
        }
        
        func completeFeedLoading(with feed: [Person] = [], hasNext: Bool = false, at index: Int = 0) {
            feedRequests[index](.success((feed, hasNext)))
        }
        
        func completeFeedLoadingWithError(at index: Int = 0) {
            let error = anyNSError()
            feedRequests[index](.failure(error))
        }
        
    }
    
}
