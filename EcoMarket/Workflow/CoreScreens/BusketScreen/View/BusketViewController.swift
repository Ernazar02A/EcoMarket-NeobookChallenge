//
//  BusketViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit

class BusketViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Корзина"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Очистить", style: .done, target: self, action: #selector(cleanBusket))
    }
    
    @objc private func cleanBusket() {
        
    }

}
