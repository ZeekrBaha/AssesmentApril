//
//  Assesment_wlmrtUITests.swift
//  Assesment_wlmrtUITests
//
//  Created by Baha Sadyr on 4/16/25.
//

import XCTest


final class Assesment_wlmrtUITests: XCTestCase {

    var app: XCUIApplication!
    var page: CountriesListPage!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        print(app.debugDescription)
        page = CountriesListPage(app: app)
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

        func test_countryListAppears() {
        print(app.debugDescription)
        XCTAssertTrue(page.countryTable.waitForExistence(timeout: 5), "Country table should appear")
        XCTAssertGreaterThan(page.countryTable.cells.count, 0, "There should be at least one country in the list")
    }

    func test_searchFiltersResults_exactMatch() {
        print(app.debugDescription)
        page.searchForCountry("Germany")
            .waitForCountryCell(code: "DE")
            .assertNumberOfRows(expected: 1)
    }

    func test_searchFiltersResults_partialMatch() {
        page.searchForCountry("Ger")
        let exists = page.countryTable.cells.firstMatch.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "At least one result should appear for partial match")
        XCTAssertGreaterThanOrEqual(page.countryTable.cells.count, 1, "Expected at least 1 row for partial match")
        page.waitForCountryCell(code: "DE")
    }

    func test_searchFiltersResults_lowercasedMatch() {
        page.searchForCountry("germany")
            .waitForCountryCell(code: "DE")
            .assertNumberOfRows(expected: 1)
    }

    func test_searchFiltersResults_byCapital() {
        page.searchForCountry("Berlin")
            .waitForCountryCell(code: "DE")
            .assertNumberOfRows(expected: 1)
    }

    func test_searchClearedRestoresFullList() {
        page.searchForCountry("France")
        page.searchBar.clearText()
        page.searchForCountry("")
        XCTAssertGreaterThan(page.countryTable.cells.count, 1, "Country list should restore after clearing search")
    }
}



final class CountriesListPage {
    
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }
    var searchBar: XCUIElement {
        app.searchFields["searchBar"]
    }

    var countryTable: XCUIElement {
        app.tables["countryTable"]
    }

    func cell(for countryCode: String) -> XCUIElement {
        countryTable.cells.matching(identifier: "countryCell_\(countryCode)").firstMatch
    }

    var emptyStateLabel: XCUIElement {
        app.staticTexts["emptyStateLabel"]
    }

    @discardableResult
    func searchForCountry(_ query: String) -> Self {
        XCTAssertTrue(searchBar.waitForExistence(timeout: 3), "Search bar not found")
        searchBar.tap()
        searchBar.typeText(query)
        sleep(1)
        return self
    }

    @discardableResult
    func waitForCountryCell(code: String, timeout: TimeInterval = 5.0) -> Self {
        let cell = cell(for: code)
        XCTAssertTrue(cell.waitForExistence(timeout: timeout), "Country cell \(code) should appear")
        return self
    }

    @discardableResult
    func assertEmptyStateVisible() -> Self {
        XCTAssertTrue(emptyStateLabel.waitForExistence(timeout: 3), "Empty state label not visible")
        return self
    }

    @discardableResult
    func assertNumberOfRows(expected: Int) -> Self {
        XCTAssertEqual(countryTable.cells.count, expected, "Expected \(expected) rows")
        return self
    }
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else { return }
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
}
