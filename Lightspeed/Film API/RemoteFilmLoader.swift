//
//  RemoteFilmLoader.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

public final class RemoteFilmLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public typealias Result = Swift.Result<Film, Swift.Error>
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) -> HTTPClientTask {
        return client.get(from: url) { result in
            switch result {
            case let .success((data, response)):
                completion(RemoteFilmLoader.map(data, from: response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try RemoteFilmMapper.map(data, from: response)
            return .success(items.toModel())
        } catch {
            return .failure(error)
        }
    }
}

private extension  RemoteFilmModel {
    func toModel() -> Film {
        return Film(id: UUID(), name: self.title, openingCrawl: self.opening_crawl, url: URL(string: self.url)!)
    }
}

