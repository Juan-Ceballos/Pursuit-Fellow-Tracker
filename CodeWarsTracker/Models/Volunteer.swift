//
//  Volunteer.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/9/21.
//

import Foundation

struct Volunteer:Codable, Hashable, TableViewCellConformance {
    var title: String
    var subtitle: String?
    var imageURLLink: String?
    var other: String?
}


