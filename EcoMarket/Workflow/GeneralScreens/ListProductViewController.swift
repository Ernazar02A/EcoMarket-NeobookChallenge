//
//  ListProductViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 15/12/23.
//

import UIKit

class ListProductViewController: BaseViewController {

    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Быстрый поиск"
        return view
    }()
    
    override func setupView() {
        view.addSubview(searchBar)
        
    }
}
