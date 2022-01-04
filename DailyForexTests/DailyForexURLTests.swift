//
//  DailyForexUrlTests.swift
//  DailyForexTests
//
//  Created by Jithin on 04/01/22.
//

import XCTest
@testable import DailyForex

class DailyForexURLTests: XCTestCase {

    var forexResource: ForexResource!
    let expectedScheme = "https"
    let expectedBaseUrl = "content.dailyfx.com"
    let expectedPath = "/api/v1/dashboard"
    let expectedMethod = "GET"
    let expectedParams: [URLQueryItem] = []

    override func setUp() {
        super.setUp()
        forexResource = ForexResource()
    }
    override func tearDown() {
        super.tearDown()
        forexResource = nil
    }

    func testURLSchemeIsCorrect() {
        let scheme = forexResource.scheme
        XCTAssertEqual(scheme, expectedScheme, "scheme does not match with expected scheme")
    }

    func testBaseUrlIsCorrect() {
        let baseUrl = forexResource.baseURL
        XCTAssertEqual(baseUrl, expectedBaseUrl, "Base URL does not match with expected base URL")
    }

    func testURLPathIsCorrect() {
        let path = forexResource.path
        XCTAssertEqual(path, expectedPath, "path does not match with expected path")
    }

    func testURLMethodIsCorrect() {
        let method = forexResource.method
        XCTAssertEqual(method, expectedMethod, "URL method does not match with expected method")
    }

    func testURLparametersAreCorrect() {
        let expectedCount = expectedParams.count
        let count = forexResource.parameters.count
        XCTAssertEqual(count, expectedCount, "Url Parameters  does not match with expected parameters")

    }

    func testURLIsCorrect() {
        var components = URLComponents()
        components.scheme = expectedScheme
        components.host = expectedBaseUrl
        components.path = expectedPath
        components.queryItems = []
        let expectedURL = components.url
        let url = forexResource.URL
        XCTAssertEqual(url, expectedURL, "URL does not match with expected URL")
    }

}
