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
    
    static func postUser(user: User, completion: @escaping (Result<Bool, AppError>)->()){
        let endPointURLString = "https://codewars-tracker-be.herokuapp.com/users"

        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badURL(endPointURLString)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let data = try JSONEncoder().encode(user)
            request.httpBody = data
            NetworkHelper.shared.performDataTask(request: request) { (result) in
                switch result{
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        }catch{
            completion(.failure(.encodingError(error)))
        }
    }
}
