//
//  UILabel+Factory.swift.swift
//  Assesment_wlmrt
//
//  Created by Baha Sadyr on 4/16/25.
//


import UIKit

extension UILabel {
    static func make(
        font: UIFont = .systemFont(ofSize: 14),
        textColor: UIColor = .label,
        alignment: NSTextAlignment = .left
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment
        return label
    }
}

