//
//  BusketView.swift
//  EcoMarket
//
//  Created by Ernazar on 24/12/23.
//

import UIKit

class BusketView: UIButton {
    private let busketImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "busket")?.withTintColor(.white)
        view.startAnimating()
        return view
    }()
    
    private let busketTitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .medium)
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
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        backgroundColor = .mainGreen
        layer.cornerRadius = 25
        
        addSubview(busketImageView)
        addSubview(busketTitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            busketImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            busketImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            busketImageView.widthAnchor.constraint(equalToConstant: 24),
            busketImageView.heightAnchor.constraint(equalToConstant: 24),
            
            busketTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            busketTitleLabel.leadingAnchor.constraint(equalTo: busketImageView.trailingAnchor, constant: 6),
        ])
    }
    
    func setupPrice(price: Int) {
        busketTitleLabel.text = "Корзина \(price) c"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
