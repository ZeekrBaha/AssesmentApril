//
//  CountriesViewController.swift
//  Assesment_wlmrt
//
//  Created by Baha Sadyr on 4/16/25.
//


import UIKit

class CountriesViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.accessibilityIdentifier = "countryTable"
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.keyboardDismissMode = .interactive
        table.register(CountryCell.self, forCellReuseIdentifier: CountryCell.reuseId)
        return table
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search by name or capital"
        sc.hidesNavigationBarDuringPresentation = false
        return sc
    }()
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No countries found."
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = "emptyStateLabel"
        return label
    }()
    
    private lazy var viewModel: CountriesViewModel = {
        let vm = CountriesViewModel(service: CountriesService())
        vm.onDataChanged = { [weak self] in
            self?.tableView.reloadData()
            self?.updateEmptyState()
        }
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = false
        DispatchQueue.main.async {
            if let searchTextField = self.searchController.searchBar.value(forKey: "searchField") as? UITextField {
                searchTextField.accessibilityIdentifier = "searchBar"
            }
        }
        setupTableView()
        viewModel.fetchCountries()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func updateEmptyState() {
        let hasData = viewModel.numberOfRows() > 0
        tableView.backgroundView = hasData ? nil : emptyStateLabel
        tableView.separatorStyle = hasData ? .singleLine : .none
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = viewModel.country(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.reuseId, for: indexPath) as! CountryCell
        cell.configure(with: country)
        cell.accessibilityIdentifier = "countryCell_\(country.code)"
        return cell
    }
}

extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        viewModel.filterCountries(with: query)
    }
}
