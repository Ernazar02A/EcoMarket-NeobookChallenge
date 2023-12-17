//
//  InfoViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit

class ProfileServiceButton: UIButton {
    let symbolImageView = UIImageView()
    let titleLable: UILabel = {
        let view = UILabel()
        view.textColor = #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
        view.font = .systemFont(ofSize: 15, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(with symbolImage: UIImage?, title: String, tinkColor: UIColor) {
        self.symbolImageView.image = symbolImage
        self.symbolImageView.tintColor = tinkColor
        self.titleLable.text = title
        self.titleLable.textColor = tinkColor
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        layer.cornerRadius = 8
        clipsToBounds = true
        addSubview(symbolImageView)
        addSubview(titleLable)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            symbolImageView.trailingAnchor.constraint(equalTo: titleLable.leadingAnchor, constant: -1),
            symbolImageView.heightAnchor.constraint(equalToConstant: 24),
            symbolImageView.widthAnchor.constraint(equalToConstant: 24),
            symbolImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLable.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}



extension UIButton {
    static let connectButton: (String, String) -> UIButton = { imageString, title in
        let view = UIButton()
        view.setTitle(title, for: .normal)
        view.layer.cornerRadius = 16
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //color #F8F8F8
        view.tintColor = .black
        //view.setImage(UIImage(named: imageString), for: .normal)
        return view
    }
}

class InfoViewController: BaseViewController {
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = true
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let profilImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "profilImage")
        return view
    }()
    private let textTitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Эко Маркет"
        view.font = .systemFont(ofSize: 24, weight: .bold)
        return view
    }()
    private let textLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Фрукты, овощи, зелень, сухофрукты а так же сделанные из натуральных ЭКО продуктов (варенье, салаты, соления, компоты и т.д.) можете заказать удобно, качественно и по доступной цене.\nГотовы сотрудничать взаимовыгодно с магазинами.\nНаши цены как на рынке.\nМы заинтересованы в экономии ваших денег и времени.\nСтоимость доставки 150 сом и ещё добавлен для окраину города.\nПри отказе подтвержденного заказа более 2-х раз Клиент заносится в чёрный список!!"
        //view.text = "Фрукты, овощи, зелень,"
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textColor = #colorLiteral(red: 0.7303193808, green: 0.7270888686, blue: 0.7336614728, alpha: 1)
        view.numberOfLines = 0
        return view
    }()
    
    private let buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let callButton: UIButton = ProfileServiceButton(
        with: UIImage(named: "phone"),
        title: "Позвонить",
        tinkColor: .black
    )
    private let whatsAppButton: UIButton = ProfileServiceButton(
        with: UIImage(named: "whatsapp"),
        title: "WhatsApp",
        tinkColor: .black
    )
    private let instagramButton: UIButton = ProfileServiceButton(
        with: UIImage(named: "instagram"),
        title: "Instagram",
        tinkColor: .black
    )
    
    override func setupView() {
        view.addSubview(profilImageView)
        view.addSubview(textTitleLabel)
        view.addSubview(textLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(callButton)
        buttonStackView.addArrangedSubview(whatsAppButton)
        buttonStackView.addArrangedSubview(instagramButton)
        tabBarController?.tabBar.backgroundColor = .white
    }
    
    override func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profilImageView.topAnchor.constraint(equalTo: view.topAnchor),
            profilImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profilImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profilImageView.heightAnchor.constraint(equalToConstant: 270),
            
            textTitleLabel.topAnchor.constraint(equalTo: profilImageView.bottomAnchor, constant: 16),
            textTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textLabel.topAnchor.constraint(equalTo: textTitleLabel.bottomAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonStackView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 33),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50),
    
            callButton.heightAnchor.constraint(equalToConstant: 54),
            whatsAppButton.heightAnchor.constraint(equalToConstant: 54),
            instagramButton.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
    
//    override func setupView() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(profilImageView)
//        contentView.addSubview(textTitleLabel)
//        contentView.addSubview(textLabel)
//        contentView.addSubview(buttonStackView)
//        buttonStackView.addArrangedSubview(callButton)
//        buttonStackView.addArrangedSubview(whatsAppButton)
//        buttonStackView.addArrangedSubview(instagramButton)
//    }
    
//    override func setupConstraints() {
//        scrollView.edges(superView: view)
//        contentView.edges(superView: scrollView)
//
//        NSLayoutConstraint.activate([
//            //contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.1),
//            profilImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            profilImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            profilImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            profilImageView.heightAnchor.constraint(equalToConstant: 270),
//
//            textTitleLabel.topAnchor.constraint(equalTo: profilImageView.bottomAnchor, constant: 16),
//            textTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            textTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//
//            textLabel.topAnchor.constraint(equalTo: textTitleLabel.bottomAnchor, constant: 8),
//            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//
//            buttonStackView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 33),
//            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
//
//            callButton.heightAnchor.constraint(equalToConstant: 54),
//
//            whatsAppButton.heightAnchor.constraint(equalToConstant: 54),
//
//            instagramButton.heightAnchor.constraint(equalToConstant: 54),
//        ])
//    }
}

extension UIView {
    func edges(superView: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            topAnchor.constraint(equalTo: superView.topAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
