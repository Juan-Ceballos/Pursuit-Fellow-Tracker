//
//  CodeWarsTrackerTests.swift
//  CodeWarsTrackerTests
//
//  Created by Juan Ceballos on 8/17/21.
//

import XCTest
@testable import PursuitFellowTracker

class PursuitFellowTrackerTests: XCTestCase {

    func testNetworkHelper() {
        let exp = XCTestExpectation(description: "data fetched")
        guard let url = URL(string: RequestURLString.base) else {
            XCTFail("bad url")
            return
        }
        let urlRequest = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(request: urlRequest) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
                XCTFail("\(appError)")
            case .success(let data):
                exp.fulfill()
                XCTAssertGreaterThan(data.count, 1_000, "data should be greater than \(data.count)")
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func testFetchAllUsers() {
        let exp = XCTestExpectation(description: "fetched all users")
        let firstUserIdInAPI = 226
        CWTAPIClient.fetchAllUsers { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
                XCTFail("\(appError)")
            case .success(let users):
                exp.fulfill()
                
                XCTAssertEqual(users[0][0].id, firstUserIdInAPI)
            }
        }
        
        wait(for: [exp], timeout: 15.0)
        
    }
    
    func testFetchUserById() {
        let exp = XCTestExpectation(description: "fetched a user by id")
        CWTAPIClient.fetchUserById(id: "5") { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
                XCTFail("\(appError)")
            case .success(let userById):
                exp.fulfill()
                XCTAssertEqual(userById.id, 5)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func testGetScoreboard() {
        let exp = XCTestExpectation(description: "fetched scoreboard data")
        let scoreboardId = 1
        CWTAPIClient.getScoreboardData { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
                XCTFail("\(appError)")
            case .success(let scoreboardData):
                exp.fulfill()
                XCTAssertEqual(scoreboardData.id, scoreboardId)
            }
        }
        wait(for: [exp], timeout: 5.0)

    }
    
    func testPostUser(){
        
        //Arrange
        let exp = XCTestExpectation(description: "posted user")
        let postUser = ["email": "test1@pursuit.org",
                        "githubUsername": "testUser1",
                        "name": "Test User1",
                        "role": "staff",
                        "username": "testUser1"]
        guard let user = User(postUser) else {
            XCTFail("unable to create user")
            return
        }
        
        //Act
        CWTAPIClient.postUser(user: user) { result in
            switch result {
            //Assert
            case.failure(let error):
                XCTFail("\(error)")
            case .success(let success):
                exp.fulfill()
                XCTAssert(success == true)
            }
        }
        wait(for: [exp], timeout: 5.0)

    }

}
