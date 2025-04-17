//
//  Assesment_wlmrtUnitTests.swift
//  Assesment_wlmrtUnitTests
//
//  Created by Baha Sadyr on 4/16/25.
//


import XCTest

@testable import Assesment_wlmrt

final class CountriesViewModelTests: XCTestCase {
    
    class MockCountriesService: CountriesServiceProtocol {
        var mockResult: Result<[Country], Error> = .success([])

        func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
            completion(mockResult)
        }
    }

    func test_fetchCountries_success_setsCountriesAndCallsOnDataChanged() {
        let mockService = MockCountriesService()
        let mockCountries = [
            Country(name: "USA", region: "NA", code: "US", capital: "Washington"),
            Country(name: "France", region: "EU", code: "FR", capital: "Paris")
        ]
        mockService.mockResult = .success(mockCountries)

        let viewModel = CountriesViewModel(service: mockService)
        let expectation = self.expectation(description: "onDataChanged called")

        viewModel.onDataChanged = {
            expectation.fulfill()
        }

        viewModel.fetchCountries()

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(viewModel.numberOfRows(), 2)
        XCTAssertEqual(viewModel.country(at: 0).name, "USA")
    }

    func test_fetchCountries_failure_setsEmptyAndCallsOnDataChanged() {
        let mockService = MockCountriesService()
        mockService.mockResult = .failure(NetworkError.noData)

        let viewModel = CountriesViewModel(service: mockService)
        let expectation = self.expectation(description: "onDataChanged called")

        viewModel.onDataChanged = {
            expectation.fulfill()
        }

        viewModel.fetchCountries()

        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(viewModel.numberOfRows(), 0)
    }

    func test_filterCountries_returnsMatchingResults() {
        let mockService = MockCountriesService()
        let mockCountries = [
            Country(name: "Germany", region: "EU", code: "DE", capital: "Berlin"),
            Country(name: "Brazil", region: "SA", code: "BR", capital: "Brasília")
        ]
        mockService.mockResult = .success(mockCountries)

        let viewModel = CountriesViewModel(service: mockService)
        viewModel.fetchCountries()

        viewModel.filterCountries(with: "bra")
        XCTAssertEqual(viewModel.numberOfRows(), 1)
        XCTAssertEqual(viewModel.country(at: 0).name, "Brazil")
    }
}
