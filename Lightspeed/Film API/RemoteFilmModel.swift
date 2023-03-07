//
//  RemoteFilmModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

public struct RemoteFilmModel: Decodable {
    let title: String
    let episode_id: Int
    let opening_crawl: String
    let director: String
    let url: String
}
