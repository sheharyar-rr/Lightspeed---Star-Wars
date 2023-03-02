//
//  RemoteFilmLoader.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

import Foundation

public final class RemoteFilmLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = Swift.Result<Film, Error>
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() async throws -> Result {
        print("Load film invoked: \(url.absoluteString)")
        do {
            let result = try await client.get(from: url).map({ data,response in
                return RemoteFilmLoader.map(data, from: response)
            })
            return try result.get()
        } catch {
            return Result.failure(.connectivity)
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try RemoteFilmMapper.map(data, from: response)
            return .success(items.toModel())
        } catch {
            return .failure(error as! RemoteFilmLoader.Error)
        }
    }
}

private extension  RemoteFilmModel {
    func toModel() -> Film {
        return Film(id: UUID(), name: self.title, openingCrawl: self.opening_crawl, url: URL(string: self.url)!)
    }
}

