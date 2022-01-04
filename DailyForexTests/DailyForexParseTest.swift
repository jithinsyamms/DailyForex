//
//  DailyForexParseTest.swift
//  DailyForexTests
//
//  Created by Jithin on 04/01/22.
//

import XCTest
@testable import DailyForex

class DailyForexParseTest: XCTestCase {

    func testCanParseForex() throws {
        let bundle = Bundle(for: type(of: self))
        guard let json = bundle.url(forResource: "forex", withExtension: "json") else {
            XCTFail("Missing file: forex.json")
            return
        }
        let jsonData = try Data(contentsOf: json)
        let forexData = try JSONDecoder().decode(Forex.self, from: jsonData)

        XCTAssertNotNil(forexData)
        XCTAssertNil(forexData.breakingNews)
        XCTAssertNotNil(forexData.topNews)
        XCTAssertNotNil(forexData.dailyBriefings)
        XCTAssertNotNil(forexData.technicalAnalysis)
        XCTAssertNotNil(forexData.specialReport)

        XCTAssertGreaterThan(forexData.topNews?.count ?? 0, 0)
        XCTAssertGreaterThan(forexData.technicalAnalysis?.count ?? 0, 0)
        XCTAssertGreaterThan(forexData.specialReport?.count ?? 0, 0)
    }

}
