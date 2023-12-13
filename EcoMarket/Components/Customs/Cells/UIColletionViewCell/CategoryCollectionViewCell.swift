//
//  CategoryCollectionViewCell.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    private lazy var productCategoryImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.743064842)
        view.frame = self.contentView.bounds
        view.applyGradientMask(colors: [UIColor.clear, color], locations: [0.1, 1.0])
        return view
    }()
    
    private let productCategoryTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.addSubview(productCategoryImageView)
        contentView.addSubview(productCategoryTitleLabel)
    }
    private func setupConstraints() {
        let standartMargin = 12.0
        NSLayoutConstraint.activate([
            productCategoryTitleLabel.leadingAnchor.constraint(equalTo: productCategoryImageView.leadingAnchor, constant: standartMargin),
            productCategoryTitleLabel.trailingAnchor.constraint(equalTo: productCategoryImageView.trailingAnchor, constant: -standartMargin),
            productCategoryTitleLabel.bottomAnchor.constraint(equalTo: productCategoryImageView.bottomAnchor, constant: -standartMargin),
        ])
    }
    
    open func setupData(_ category: ProductCategory) {
        productCategoryTitleLabel.text = category.name
        productCategoryImageView.kf.setImage(with: URL(string: category.image))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
