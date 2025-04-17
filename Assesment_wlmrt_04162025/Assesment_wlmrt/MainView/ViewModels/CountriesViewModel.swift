//
//  CountriesViewModel.swift
//  Assesment_wlmrt
//
//  Created by Baha Sadyr on 4/16/25.
//

import Foundation


class CountriesViewModel {
    
    private let service: CountriesServiceProtocol
    private(set) var allCountries: [Country] = []
    private(set) var filteredCountries: [Country] = []
    var onDataChanged: (() -> Void)?
    var onLoadingChanged: ((Bool) -> Void)?
    
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
        onLoadingChanged?(true)
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }

            let results: [Country]
            if query.isEmpty {
                results = self.allCountries
            } else {
                results = self.allCountries.filter {
                    $0.name.lowercased().contains(query.lowercased()) ||
                    $0.capital.lowercased().contains(query.lowercased())
                }
            }
            DispatchQueue.main.async {
                self.filteredCountries = results
                self.onLoadingChanged?(false)
                self.onDataChanged?()
            }
        }
    }
    
    func country(at index: Int) -> Country {
        filteredCountries[index]
    }
    
    func numberOfRows() -> Int {
        filteredCountries.count
    }
}
