//
//  UIView+Extensions.swift.swift
//  Assesment_wlmrt
//
//  Created by Baha Sadyr on 4/16/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

extension Array where Element: UIView {
    func translates(_ value: Bool) {
        forEach { $0.translatesAutoresizingMaskIntoConstraints = value }
    }
}

