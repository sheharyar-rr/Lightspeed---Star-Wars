//
//  RemotePersonLoader.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

public final class RemotePersonLoader: PersonFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = PersonFeedLoader.Result
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) {[weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success((data, response)):
                completion(RemotePersonLoader.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let items = try RemotePersonMapper.map(data, from: response)
            return .success(items.toModels())
        } catch {
            return .failure(error)
        }
    }
}

private extension Array where Element == RemotePersonModel {
    func toModels() -> [Person] {
        return map {
            Person(id: UUID(), name: $0.name, dateOfBirth: $0.birth_year, physicalAttributes: [PhysicalAttribute(attribute: "Gender", value: $0.gender), PhysicalAttribute(attribute: "Eye color", value: $0.eye_color), PhysicalAttribute(attribute: "Hair Color", value: $0.hair_color), PhysicalAttribute(attribute: "Height", value: $0.height), PhysicalAttribute(attribute: "Mass", value: $0.mass), PhysicalAttribute(attribute: "Skin Color", value: $0.skin_color)], films: $0.films.compactMap({ url in
                return Film(name: nil, openingCrawl: nil, url: URL(string: url)!)
            }))
        }
    }
}
