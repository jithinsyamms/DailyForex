//
//  DailyForexInvalidNetworkTest.swift
//  DailyForexTests
//
//  Created by Jithin on 04/01/22.
//

import XCTest
@testable import DailyForex

class DailyForexInvalidNetworkTest: XCTestCase {

    struct MockResource: APIResource {
        typealias Model = Forex
        var scheme: String {
            "https"
        }
        var baseURL: String {
            Constants.BaseURL
        }
        var path: String {
            // invalid path
            "/api/v1/dashboar"
        }
        var method: String {
            "GET"
        }
    }

    var resource: MockResource!
    var request: ForexRequest<MockResource>!

    override func setUp() {
        resource = MockResource()
        request = ForexRequest(resource: resource)
    }

    override func tearDown() {
        resource = nil
        request = nil
    }

    func testForexInvalidRequest() throws {

        let expectation = self.expectation(description: "DailyForexInvalidNetworkTest")
        request.execute { response in
            XCTAssertNotNil(response)
            switch response {
            case .success:
                XCTFail("Expected failure, but returns success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }

            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
