//
//  CWTAPIClient.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/23/21.
//

import Foundation

class CWTAPIClient {
    public static func fetchAllUsers(completion: @escaping (Result<[[User]], AppError>) -> ()) {
        
        // will fetch json data using base url for fetching array of all users
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
                    // do the work here to split up all the users into the different
                    // cohort categories and parse into array of different User Model arrays
                    var usersByCohort = [[User]]()
                    let userWrapper = try JSONDecoder().decode([User].self, from: data)
                    let userWrapperSO = userWrapper.filter {$0.cohort == "Pursuit-7.1"}
                    let userWrapperST = userWrapper.filter {$0.cohort == "Pursuit-7.2"}
                    let userWrapperEO = userWrapper.filter {$0.cohort == "Pursuit-8.1"}
                    let userWrapperET = userWrapper.filter {$0.cohort == "Pursuit-8.2"}
                    
                    usersByCohort.append(userWrapper)
                    usersByCohort.append(userWrapperSO)
                    usersByCohort.append(userWrapperST)
                    usersByCohort.append(userWrapperEO)
                    usersByCohort.append(userWrapperET)
                    
                    completion(.success(usersByCohort))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    // specifically for by user id endpoint, will be used for grabbing specific user for detail view
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
    
    // use scoreboard endpoint to fetch up to date scoreboard data
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
                completion(.failure(appError))
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
    
    // will post new user to json api when user signs up
    static func postUser(user: User, completion: @escaping (Result<Bool, AppError>)->()){
        let endPointURLString = RequestURLString.query
        
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
