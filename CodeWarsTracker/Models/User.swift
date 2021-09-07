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

struct User: Codable, Hashable {
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
    
    init(_ dict: [String:Any]) {
        self.id = dict["id"] as? Int ?? 0
        self.username = dict["username"] as? String ?? ""
        self.honor = dict["honor"] as? Int ?? 0
        self.codewarsid = dict["codewarsid"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.role = dict["role"] as? String ?? ""
        self.language = dict["language"] as? String ?? ""
        self.pointThisWeek = dict["pointThisWeek"] as? Int ?? 0
        self.pointThisMonth = dict["pointThisMonth"] as? Int ?? 0
        self.email = dict["email"] as? String ?? ""
        self.clan = dict["clan"] as? String ?? ""
        self.githubUsername = dict["githubUsername"] as? String ?? ""
    }
}

private enum CodingKeys: String, CodingKey {
    case pointsThisWeek = "points_this_week"
    case pointsThisMonth = "points_this_month"
    case githubUsername = "github_username"
}



