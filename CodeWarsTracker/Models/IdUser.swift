//
//  IdUser.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/23/21.
//

import Foundation

struct IdUserWrapper: Decodable {
    let fellowData: IdUser
}

struct IdUser: Decodable {
    let id: Int
}
