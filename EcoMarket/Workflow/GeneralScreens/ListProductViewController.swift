//
//  ListProductViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 15/12/23.
//

import UIKit

//class ListProductViewController: BaseViewController {
//
//    private let searchBar: UISearchBar = {
//        let view = UISearchBar()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.placeholder = "Быстрый поиск"
//        return view
//    }()
//
//    override func setupView() {
//        view.addSubview(searchBar)
//
//    }
//}
class ListProductViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Быстрый поиск"
        return view
    }()

    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let categories = ["Категория 1", "Категория 2", "Категория 3"]
    var selectedCategoryIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self

        productCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self

        view.addSubview(categoryCollectionView)
        view.addSubview(productCollectionView)
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            
            categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 50),

            productCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categories.count
        } else {
            return selectedCategoryIndex != nil ? 10 : 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
            cell.categoryLabel.text = categories[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
            cell.productLabel.text = "Продукт \(indexPath.row + 1)"
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            selectedCategoryIndex = indexPath.item
            productCollectionView.reloadData()
        } else {
            // Обработка выбора продукта
        }
    }
}

class CategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCell"

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 30
        contentView.layer.borderColor = #colorLiteral(red: 0.8571347594, green: 0.8542680144, blue: 0.8668256402, alpha: 1)
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.width = ceil(size.width)
        layoutAttributes.frame = newFrame

        return layoutAttributes
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductCell"

    let productLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productLabel)

        NSLayoutConstraint.activate([
            productLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            productLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
