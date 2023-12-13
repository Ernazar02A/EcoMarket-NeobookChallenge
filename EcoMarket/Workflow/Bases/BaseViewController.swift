//
//  BaseViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    open func setup() {
        view.backgroundColor = .bgColor
        setupView()
        setupConstraints()
    }
    
    open func setupView() {}
    open func setupConstraints() {}
}
