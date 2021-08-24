//
//  Fellow.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/23/21.
//

import Foundation

struct UserWrapper: Decodable {
    let users: [User]
}

struct User: Decodable {
    let id: Int
}
