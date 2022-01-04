//
//  DailyForexNetworkTest.swift
//  DailyForexTests
//
//  Created by Jithin on 04/01/22.
//

import XCTest
@testable import DailyForex

class DailyForexNetworkTest: XCTestCase {

    func testForexRequestReturnsForexResponse() throws {

        let resource = ForexResource()
        let request = ForexRequest(resource: resource)
        let expectation = self.expectation(description: "ForexRequestReturnsForexResponse")
        request.execute { response in
            XCTAssertNotNil(response)
            switch response {
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            case .success(let value):
                XCTAssertNotNil(value)
            }

            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
