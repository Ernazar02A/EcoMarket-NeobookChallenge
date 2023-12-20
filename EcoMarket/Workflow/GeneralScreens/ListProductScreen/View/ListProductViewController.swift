//
//  ListProductViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 15/12/23.
//

import UIKit

class ListProductViewController: UIViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    
    private lazy var searchController: UISearchController = {
        let view = UISearchController()
        view.searchResultsUpdater = self
        view.searchBar.searchBarStyle = .minimal
        view.searchBar.placeholder = "Быстрый поиск"
        return view
    }()
    
    private let customSegmentControl = CustomSegmentedControl("Все", "Фрукты", "Сухофрукты", "Зелень","Овощи", "Чай кофе", "Молочные продукты")

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let categories = ["Все", "Фрукты", "Сухофрукты", "Зелень","Овощи", "Чай кофе", "Молочные продукты"]
    
    var selectedCategoryIndex: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Продукты"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        let index = categories.firstIndex(where: {$0 == selectedCategoryIndex})
        customSegmentControl.firstSelectedSegment(tag: index ?? 0)
    }

    func setup() {
        view.backgroundColor = .white
        //view.addSubview(categoryCollectionView)
        view.addSubview(customSegmentControl)

        NSLayoutConstraint.activate([
            customSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            customSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            customSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            customSegmentControl.heightAnchor.constraint(equalToConstant: 27),
            //productCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            //productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //productCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension ListProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.productLabel.text = "Продукт \(indexPath.row + 1)"
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ListProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}
