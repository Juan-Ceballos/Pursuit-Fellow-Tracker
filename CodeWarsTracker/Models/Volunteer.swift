//
//  Volunteer.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/9/21.
//

import Foundation

struct Volunteer:Codable, Hashable {
    let name: String
    let contactLink: String?
    let profileImageURL: String?
}
