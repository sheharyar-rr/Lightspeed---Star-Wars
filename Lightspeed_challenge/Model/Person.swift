//
//  PeopleModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

public struct Person: Identifiable {
    public let id: UUID
    public let name: String
    public let dateOfBirth: String
    public let films: [Film]
}
