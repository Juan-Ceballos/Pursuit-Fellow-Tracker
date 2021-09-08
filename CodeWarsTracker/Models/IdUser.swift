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
    let username: String
    let honor: Int?
    let codewarsid: String?
    let name: String
    let role: String
    let language: String
    let pointThisWeek: Int?
    let pointThisMonth: Int?
    let email: String?
    let clan: String?
    let githubUsername: String?
    let problems: [Problem]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case honor
        case codewarsid
        case name
        case role
        case language
        case pointThisWeek = "points_this_week"
        case pointThisMonth = "points_this_month"
        case email
        case clan
        case githubUsername = "github_username"
        case problems
    }
}
struct Problem: Decodable {
    let id: String
    let name: String
    let slug: String
    let completedLanguages: [String]
    let completedAt: String
}


