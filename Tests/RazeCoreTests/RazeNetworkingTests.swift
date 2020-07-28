//
//  RazeNetworkingTests.swift
//  RazeCoreTests
//
//  Created by Vasile Morari on 7/27/20.
//

import XCTest
@testable import RazeCore

final class RazeNetworkingTests: XCTestCase {
    
    func testLoadDataCall() {
        let manager = RazeCore.Networking.Manager()
        
        let expectation = XCTestExpectation(description: "Called for data")
        
        guard let url = URL(string: "https://www.raywenderlich.com") else {
            return XCTFail("Could not create URL properly")
        }
        
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                XCTAssertNotNil(returnedData, "Response data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "Error forming error result")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    static var allTests = [
        ("testLoadDataCall", testLoadDataCall)
    ]
    
}
