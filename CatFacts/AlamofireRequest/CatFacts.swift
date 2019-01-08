//
//  CatFacts.swift
//  CatFacts
//
//  Created by Serhii PERKHUN on 1/8/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import Foundation

struct CatFacts: Codable {
    let all: [All]?
}

struct All: Codable {
    let text: String?
    let user: User?
}

struct User: Codable {
    let name: Name?
}

struct Name: Codable {
    let first, last: String?
}
