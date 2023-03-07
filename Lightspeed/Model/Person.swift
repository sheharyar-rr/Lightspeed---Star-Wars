//
//  PeopleModel.swift
//  Lightspeed_challenge
//
//  Created by Sheharyar Irfan on 2023-03-01.
//

import Foundation

public struct Person: Identifiable, Equatable {
    public static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    public let id: UUID
    public let name: String
    public let dateOfBirth: String
    public let physicalAttributes: [PhysicalAttribute]
    public let films: [Film]
    
    public init(id: UUID, name: String, dateOfBirth: String, physicalAttributes: [PhysicalAttribute], films: [Film]) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.physicalAttributes = physicalAttributes
        self.films = films
    }
}

public struct PhysicalAttribute: Identifiable {
    public let id: UUID
    public let attribute: String
    public let value: String
    public init(id: UUID = UUID(), attribute: String, value: String) {
        self.id = id
        self.attribute = attribute
        self.value = value
    }
}
