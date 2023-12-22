//
//  EmtyView.swift
//  EcoMarket
//
//  Created by Ernazar on 22/12/23.
//

import UIKit

class EmtyView: UIView {
    private var emtyImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "emty")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Ничего не нашли"
        view.textColor = #colorLiteral(red: 0.7303193808, green: 0.7270888686, blue: 0.7336614728, alpha: 1) //color #ACABAD
        view.font = .systemFont(ofSize: 17.6, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(emtyImageView)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emtyImageView.topAnchor.constraint(equalTo: topAnchor, constant: 75),
            emtyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emtyImageView.widthAnchor.constraint(equalToConstant: 200),
            emtyImageView.heightAnchor.constraint(equalToConstant: 224),
            
            titleLabel.topAnchor.constraint(equalTo: emtyImageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
