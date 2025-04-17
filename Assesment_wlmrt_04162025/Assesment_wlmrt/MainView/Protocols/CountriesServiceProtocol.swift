//
//  CountriesServiceProtocol.swift
//  Assesment_wlmrt
//
//  Created by Baha Sadyr on 4/16/25.
//

import Foundation

protocol CountriesServiceProtocol {
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void)
}
