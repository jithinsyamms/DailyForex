//
//  DailyForexViewModelTest.swift
//  DailyForexTests
//
//  Created by Jithin on 04/01/22.
//

import XCTest
@testable import DailyForex

class DailyForexViewModelTest: XCTestCase {

    func testViewModelDataSetUp() throws {

        let bundle = Bundle(for: type(of: self))
        guard let json = bundle.url(forResource: "forex", withExtension: "json") else {
                XCTFail("Missing file: forex.json")
                    return
        }
        let viewModel = ForexDataModel()
        let jsonData = try Data(contentsOf: json)
        let forexData = try JSONDecoder().decode(Forex.self, from: jsonData)
        XCTAssertNotNil(forexData)
        viewModel.forex = forexData
        viewModel.setForexData()

        XCTAssertGreaterThan(viewModel.sections.count, 0)
        XCTAssertGreaterThan(viewModel.forexDict.count, 0)
        XCTAssertNotNil(viewModel.headerNews)
        for section in viewModel.sections {
            XCTAssertNotNil(viewModel.getForexItems(section: section))
            XCTAssertGreaterThan(viewModel.getForexItems(section: section).count, 0)
        }
    }

}
