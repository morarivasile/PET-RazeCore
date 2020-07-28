//
//  RazeNetworkingTests.swift
//  RazeCoreTests
//
//  Created by Vasile Morari on 7/27/20.
//

import XCTest
@testable import RazeCore

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?
    
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}

final class RazeNetworkingTests: XCTestCase {
    
    func testLoadDataCall() {
        let manager = RazeCore.Networking.Manager()
        let session = NetworkSessionMock()
        
        manager.session = session
        
        let expectation = XCTestExpectation(description: "Called for data")
        
        let data = Data([0, 1, 0, 1])
        
        session.data = data
        
        let url = URL(fileURLWithPath: "url")
        
        
        
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case .success(let returnedData):
                XCTAssertEqual(data, returnedData, "Manager returned unexpected data")
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
