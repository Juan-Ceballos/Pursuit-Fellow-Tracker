//
//  ScoreCard.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/23/21.
//

import Foundation

struct ScoreBoard:Codable {
    let id: Int
    let fellowsThisWeek: Int
    let fellowsThisMonth: Int
    let staffThisWeek: Int
    let staffThisMonth: Int
    let fellowsAllTime: Int
    let staffAllTime: Int
    // again
    private enum CodingKeys: String, CodingKey {
        case id
        case fellowsThisWeek = "fellows_this_week"
        case fellowsThisMonth = "fellows_this_month"
        case staffThisWeek = "staff_this_week"
        case staffThisMonth = "staff_this_month"
        case fellowsAllTime = "fellows_all_time"
        case staffAllTime = "staff_all_time"
    }
}


