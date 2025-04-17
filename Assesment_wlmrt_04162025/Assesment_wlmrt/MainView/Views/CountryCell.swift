//
//  CountryCell.swift
//  Assesment_wlmrt
//
//  Created by Baha Sadyr on 4/16/25.
//

import UIKit

class CountryCell: UITableViewCell {

    static var reuseId = "CountryCell"

    private lazy var nameLabel = UILabel.make(
        font: .boldSystemFont(ofSize: 16)
    )

    private lazy var codeLabel = UILabel.make(
        font: .systemFont(ofSize: 16),
        alignment: .right
    )

    private lazy var capitalLabel = UILabel.make(
        font: .systemFont(ofSize: 14),
        textColor: .gray
    )

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubviews(nameLabel, codeLabel, capitalLabel)
        [nameLabel, codeLabel, capitalLabel].translates(false)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: codeLabel.leadingAnchor, constant: -8),

            codeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            capitalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            capitalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            capitalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with country: Country) {
        nameLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
        accessibilityIdentifier = "countryCell_\(country.code)"
    }
}
