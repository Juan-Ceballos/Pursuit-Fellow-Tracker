//
//  CWTAPIClient.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/23/21.
//

import Foundation

class CWTAPIClient {
    public static func fetchAllUsers(completion: @escaping (Result<[User], AppError>) -> ()) {
        
        let urlString = RequestURLString.base
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let urlRequest =  URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request: urlRequest) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let userWrapper = try JSONDecoder().decode([User].self, from: data)
                   
                completion(.success(userWrapper))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    public static func fetchUserById(id: String, completion: @escaping (Result<IdUser, AppError>) -> ()) {
        let urlString = RequestURLString.query + id
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request: urlRequest) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let userWrapped = try JSONDecoder().decode(IdUserWrapper.self, from: data)
                    let user = userWrapped.fellowData
                    completion(.success(user))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    public static func getScoreboardData(completion: @escaping (Result<ScoreBoard, AppError>) -> ()){
        let urlString = RequestURLString.scoreboard
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request: urlRequest) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let data):
                do {
                    let scoreboard = try JSONDecoder().decode(ScoreBoard.self, from: data)
                    completion(.success(scoreboard))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}