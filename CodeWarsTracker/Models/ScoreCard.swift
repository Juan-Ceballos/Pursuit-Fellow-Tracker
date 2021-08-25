//
//  ScoreCard.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/23/21.
//

import Foundation

struct ScoreBoard:Codable {
    let id: Int
    let fellows_this_week: Int
    let fellows_this_month: Int
    let staff_this_week: Int
    let staff_this_month: Int
    let fellows_all_time: Int
    let staff_all_time: Int
}
