//
//  UIImageView + extension.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit

extension UIImageView {
    func applyGradientMask(colors: [UIColor], locations: [NSNumber]?) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.addSublayer(gradientLayer)
    }
}
