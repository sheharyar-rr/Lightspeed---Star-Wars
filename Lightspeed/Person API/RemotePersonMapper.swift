//
//  RemotePersonMapper.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

final class RemotePersonMapper {
    
    private struct Root: Decodable {
        let results: [RemotePersonModel]
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemotePersonModel] {
        guard isOK(response),
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemotePersonLoader.Error.invalidData
        }
        return root.results
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        (200...299).contains(response.statusCode)
    }
}
