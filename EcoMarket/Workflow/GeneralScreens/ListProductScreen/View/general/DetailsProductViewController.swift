//
//  DetailsProductViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 26/12/23.
//

import UIKit

class DetailsProductViewController: BaseViewController {
    
    private lazy var productView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.7
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(addTap), for: .touchUpInside)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = .mainGreen
        view.setTitle("Добавить", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var product: Product
    
    weak var delegate: ProductCollectionViewCellDelegate?
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    override func setup() {
        super.setup()
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .down {
            dismiss(animated: true) {
                self.blurView.effect = nil
            }
        }
    }
    
    @objc private func addTap() {
        guard let count = product.count else {
            product.count = 1
            delegate?.sendToBusket(count: product.count ?? 1, id: product.id)
            return
        }
        delegate?.sendToBusket(count: count, id: product.id)
    }
    
    override func setupView() {
        view.backgroundColor = .clear
        view.addSubview(blurView)
        blurView.frame = view.bounds
        view.addSubview(productView)
        productView.addSubview(addButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            productView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            productView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            addButton.heightAnchor.constraint(equalToConstant: 54),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -16),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
