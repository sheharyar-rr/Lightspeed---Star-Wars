//
//  FeedLoader.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

public protocol PersonFeedLoader {
    typealias Result = Swift.Result<([Person], HasNext:Bool), Error>
    
    func load(next: Bool, completion: @escaping (Result) -> Void)
}
