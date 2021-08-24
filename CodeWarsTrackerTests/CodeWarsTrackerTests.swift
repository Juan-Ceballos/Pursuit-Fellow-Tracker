//
//  CodeWarsTrackerTests.swift
//  CodeWarsTrackerTests
//
//  Created by Juan Ceballos on 8/17/21.
//

import XCTest
@testable import CodeWarsTracker

class CodeWarsTrackerTests: XCTestCase {

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

}
