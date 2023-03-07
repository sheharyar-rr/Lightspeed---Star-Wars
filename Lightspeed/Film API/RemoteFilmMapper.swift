//
//  RemoteFilmMapper.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

final class RemoteFilmMapper {
    
    private static var OK_200: Int { return 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> RemoteFilmModel {
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(RemoteFilmModel.self, from: data) else {
            throw RemoteFilmLoader.Error.invalidData
        }
        return root
    }
}
