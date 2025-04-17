//
//  CountriesService.swift
//  Assesment_wlmrt
//
//  Created by Baha Sadyr on 4/16/25.
//

import Foundation

final class CountriesService: CountriesServiceProtocol {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }

    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        networkManager.fetchCountries { result in
            switch result {
            case .success(let countries):
                completion(.success(countries))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }
}
