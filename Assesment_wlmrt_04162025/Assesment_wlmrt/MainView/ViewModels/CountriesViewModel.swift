//
//  CountriesViewModel.swift
//  Assesment_wlmrt
//
//  Created by Baha Sadyr on 4/16/25.
//

import Foundation

//class CountriesViewModel {
//    
//    private(set) var allCountries: [Country] = []
//    private(set) var filteredCountries: [Country] = []
//    var onDataChanged: (() -> Void)?
//
//    func fetchCountries() {
//        NetworkManager.shared.fetchCountries { [weak self] result in
//            switch result {
//            case .success(let countries):
//                self?.allCountries = countries
//                self?.filteredCountries = countries
//            case .failure(let error):
//                print("Fetch failed: \(error.localizedDescription)")
//                self?.allCountries = []
//                self?.filteredCountries = []
//            }
//            self?.onDataChanged?()
//        }
//    }
//
//    func filterCountries(with query: String) {
//        guard !query.isEmpty else {
//            filteredCountries = allCountries
//            onDataChanged?()
//            return
//        }
//
//        filteredCountries = allCountries.filter {
//            $0.name.lowercased().contains(query.lowercased()) ||
//            $0.capital.lowercased().contains(query.lowercased())
//        }
//
//        onDataChanged?()
//    }
//
//    func country(at index: Int) -> Country {
//        filteredCountries[index]
//    }
//
//    func numberOfRows() -> Int {
//        filteredCountries.count
//    }
//}


class CountriesViewModel {
    
    private let service: CountriesServiceProtocol
    private(set) var allCountries: [Country] = []
    private(set) var filteredCountries: [Country] = []
    var onDataChanged: (() -> Void)?

    init(service: CountriesServiceProtocol) {
        self.service = service
    }

    func fetchCountries() {
        service.fetchCountries { [weak self] result in
            switch result {
            case .success(let countries):
                self?.allCountries = countries
                self?.filteredCountries = countries
            case .failure(let error):
                print("Error fetching countries: \(error.localizedDescription)")
                self?.allCountries = []
                self?.filteredCountries = []
            }
            self?.onDataChanged?()
        }
    }

    func filterCountries(with query: String) {
        guard !query.isEmpty else {
            filteredCountries = allCountries
            onDataChanged?()
            return
        }

        filteredCountries = allCountries.filter {
            $0.name.lowercased().contains(query.lowercased()) ||
            $0.capital.lowercased().contains(query.lowercased())
        }
        onDataChanged?()
    }

    func country(at index: Int) -> Country {
        filteredCountries[index]
    }

    func numberOfRows() -> Int {
        filteredCountries.count
    }
}
