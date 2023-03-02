//
//  FeedLoader.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[Person], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
