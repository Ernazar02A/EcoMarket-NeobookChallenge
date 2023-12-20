//
//  UIButton + Extentsions.swift
//  EcoMarket
//
//  Created by Ernazar on 20/12/23.
//

import UIKit

class SegmentedButton: UIButton {
    var label = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .medium)
        view.tintColor = #colorLiteral(red: 0.8571347594, green: 0.8542680144, blue: 0.8668256402, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        label.text = title
        setup()
    }
    
    private func setup() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    static func createSegmentedButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        let color = #colorLiteral(red: 0.8571347594, green: 0.8542680144, blue: 0.8668256402, alpha: 1)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        button.setTitleColor(color, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = color.cgColor
        return button
    }
}
