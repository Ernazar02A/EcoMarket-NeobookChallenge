//
//  ProductCollectionViewCell.swift
//  EcoMarket
//
//  Created by Ernazar on 20/12/23.
//

import UIKit
import Kingfisher

protocol ProductCollectionViewCellDelegate: AnyObject {
    func sendToBusket(count: Int, id: Int)
}

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
    
    private lazy var addButtonView: UIButton = {
        let view = UIButton()
        view.backgroundColor = #colorLiteral(red: 0.4588235294, green: 0.8588235294, blue: 0.1058823529, alpha: 1) //color #F9F9F9
        view.setTitle("Добавить", for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(addBusket), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var plusButtonView: UIButton = {
        let view = UIButton()
        view.backgroundColor = #colorLiteral(red: 0.4588235294, green: 0.8588235294, blue: 0.1058823529, alpha: 1) //color #F9F9F9
        view.setImage(UIImage(named: "plus"), for: .normal)
        view.tintColor = .white
        view.isHidden = true
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(plusAddBusket), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var minusButtonView: UIButton = {
        let view = UIButton()
        view.backgroundColor = #colorLiteral(red: 0.4588235294, green: 0.8588235294, blue: 0.1058823529, alpha: 1) //color #F9F9F9
        view.setImage(UIImage(named: "minus"), for: .normal)
        view.tintColor = .white
        view.isHidden = true
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(minusAddBusket), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let countLabel: UILabel = {
        let view = UILabel()
        view.textColor = #colorLiteral(red: 0.1622044146, green: 0.1622044146, blue: 0.1622044146, alpha: 1)
        view.text = "1"
        view.isHidden = true
        view.font = .systemFont(ofSize: 18, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var count: Int = 0 {
        didSet {
            self.countLabel.text = String(count)
        }
    }
    
    private var id: Int?
    
    private var buttonsCentered: Bool = true
    
    weak var delegate: ProductCollectionViewCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        setupView()
        setupConstraints()
    }
    
    func setupData(data: Product) {
        productImageView.kf.setImage(with: URL(string: data.image))
        productNameLabel.text = data.title
        priceLabel.text = "\(data.price) c"
        checkCount(count: data.count)
        count = data.count ?? 1
        id = data.id
    }
    
    private func checkCount(count: Int?) {
        if count == nil || count == 0 {
            self.addButtonView.isHidden = false
            self.plusButtonView.isHidden = true
            self.minusButtonView.isHidden = true
            self.countLabel.isHidden = true
        } else {
            self.addButtonView.isHidden = true
            self.plusButtonView.isHidden = false
            self.minusButtonView.isHidden = false
            self.countLabel.isHidden = false
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - targets
private extension ProductCollectionViewCell {
    
    @objc private func addBusket() {
        self.addButtonView.isHidden = true
        self.plusButtonView.isHidden = false
        self.minusButtonView.isHidden = false
        self.countLabel.isHidden = false
        delegate?.sendToBusket(count: 1, id: id ?? 0)
    }
    
    @objc private func plusAddBusket() {
        count += 1
        delegate?.sendToBusket(count: 1, id: id ?? 0)
    }
    
    @objc private func minusAddBusket() {
        if count > 1 {
            count -= 1
        }
        delegate?.sendToBusket(count: -1, id: id ?? 0)
    }
}

//MARK: - setup Views && Constraints
private extension ProductCollectionViewCell {
    func setupView() {
        contentView.addSubview(bgView)
        bgView.addSubview(productNameLabel)
        bgView.addSubview(productImageView)
        bgView.addSubview(productNameLabel)
        bgView.addSubview(priceLabel)
        bgView.addSubview(addButtonView)
        bgView.addSubview(plusButtonView)
        bgView.addSubview(minusButtonView)
        bgView.addSubview(countLabel)
    }
    
    func setupConstraints() {
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
            addButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            addButtonView.heightAnchor.constraint(equalToConstant: 32),
            
            minusButtonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            minusButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            minusButtonView.heightAnchor.constraint(equalToConstant: 32),
            minusButtonView.widthAnchor.constraint(equalToConstant: 32),
            
            plusButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            plusButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            plusButtonView.heightAnchor.constraint(equalToConstant: 32),
            plusButtonView.widthAnchor.constraint(equalToConstant: 32),
            
            countLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: plusButtonView.centerYAnchor),
        ])
    }
}
