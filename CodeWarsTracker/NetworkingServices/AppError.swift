//
//  AppError.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/23/21.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case networkClientError(Error)
    case decodingError(Error)
    case noResponse
    case noData
    case badStatusCode(Int)
}
