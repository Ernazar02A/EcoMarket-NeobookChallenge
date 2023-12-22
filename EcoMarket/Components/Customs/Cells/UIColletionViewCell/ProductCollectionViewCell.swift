//
//  ProductCollectionViewCell.swift
//  EcoMarket
//
//  Created by Ernazar on 20/12/23.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1) //color #F9F9F9
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let productNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = #colorLiteral(red: 0.1622044146, green: 0.1622044146, blue: 0.1622044146, alpha: 1) //color #1F1F1F
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.textColor = #colorLiteral(red: 0.4588235294, green: 0.8588235294, blue: 0.1058823529, alpha: 1) //color #75DB1B
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addButtonView: UIButton = {
        let view = UIButton()
        view.backgroundColor = #colorLiteral(red: 0.4588235294, green: 0.8588235294, blue: 0.1058823529, alpha: 1) //color #F9F9F9
        view.setTitle("Добавить", for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
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
        contentView.addSubview(bgView)
        bgView.addSubview(productNameLabel)
        bgView.addSubview(productImageView)
        bgView.addSubview(productNameLabel)
        bgView.addSubview(priceLabel)
        bgView.addSubview(addButtonView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            productImageView.heightAnchor.constraint(equalToConstant: 96),
            
            productNameLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 4),
            productNameLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -4),
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 4),
            
            priceLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -4),
            priceLabel.bottomAnchor.constraint(equalTo: addButtonView.topAnchor, constant: -16),
            
            addButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            addButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            addButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4),
            addButtonView.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    func setupData(data: Product) {
        productImageView.kf.setImage(with: URL(string: data.image))
        productNameLabel.text = data.title
        priceLabel.text = "\(data.price) c"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

