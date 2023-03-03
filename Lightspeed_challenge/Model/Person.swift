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
    public let physicalAttributes: [PhysicalAttribute]
    public let films: [Film]
}

public struct PhysicalAttribute: Identifiable {
    public let id: UUID
    public let attribute: String
    public let value: String
    init(id: UUID = UUID(), attribute: String, value: String) {
        self.id = id
        self.attribute = attribute
        self.value = value
    }
}
