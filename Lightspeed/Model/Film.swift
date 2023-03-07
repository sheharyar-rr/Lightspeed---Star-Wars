//
//  Film.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

public struct Film: Identifiable {
    public let id: UUID
    public let name: String
    public let openingCrawl: String
    public let url: URL

    public init(id: UUID = UUID(), name: String?, openingCrawl: String?, url: URL) {
        self.id = id
        self.name = name ?? ""
        self.openingCrawl = openingCrawl ?? ""
        self.url = url
    }
}
