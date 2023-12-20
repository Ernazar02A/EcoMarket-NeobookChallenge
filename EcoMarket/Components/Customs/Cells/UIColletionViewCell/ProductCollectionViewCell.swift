//
//  ProductCollectionViewCell.swift
//  EcoMarket
//
//  Created by Ernazar on 20/12/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductCell"
    
    let bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let productLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgView)
        bgView.addSubview(productLabel)

        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            productLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 16),
            productLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -16),
            productLabel.topAnchor.constraint(equalTo: bgView.topAnchor),
            productLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

