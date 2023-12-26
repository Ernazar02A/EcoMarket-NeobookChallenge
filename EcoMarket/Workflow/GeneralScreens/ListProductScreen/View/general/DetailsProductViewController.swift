//
//  DetailsProductViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 26/12/23.
//

import UIKit

class DetailsProductViewController: UIViewController {
    
    private var product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
