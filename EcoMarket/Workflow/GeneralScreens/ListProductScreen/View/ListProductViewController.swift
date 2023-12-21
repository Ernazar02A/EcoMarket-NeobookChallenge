//
//  ListProductViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 15/12/23.
//

import UIKit

class ListProductViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let view = UISearchController()
        view.searchResultsUpdater = self
        view.searchBar.searchBarStyle = .minimal
        view.searchBar.placeholder = "Быстрый поиск"
        return view
    }()
    
    private let customSegmentControl = CustomSegmentedControl("Все", "Фрукты", "Сухофрукты", "Зелень","Овощи", "Чай кофе", "Молочные продукты")

    private lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let categories = ["Все", "Фрукты", "Сухофрукты", "Зелень","Овощи", "Чай кофе", "Молочные продукты"]
    
    var selectedCategoryIndex: String?
    
    private var products: [Product] = [] {
        didSet {
            self.productCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let index = categories.firstIndex(where: {$0 == selectedCategoryIndex})
        customSegmentControl.firstSelectedSegment(tag: index ?? 0)
    }

    private func setup() {
        setupView()
        setupConstraints()
        setupNavigationContoller()
        setupData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(productCollectionView)
        view.addSubview(customSegmentControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            customSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            customSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            customSegmentControl.heightAnchor.constraint(equalToConstant: 27),
            
            productCollectionView.topAnchor.constraint(equalTo: customSegmentControl.bottomAnchor, constant: 24),
            productCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupNavigationContoller() {
        title = "Продукты"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupData() {
        let categoryString = selectedCategoryIndex ?? ""
        NetworkService.shared.fetchProducts(with: categoryString) { [weak self] result in
            guard let self = self else { return }
            self.fetchHandlerResult(result)
        }
    }
    
    private func fetchHandlerResult(_ result: Result<[Product], TypeRequestError>) {
        switch result {
        case .success(let data):
            self.products = data
        case .failure(let error):
            print(error)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ListProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = products[indexPath.row]
        cell.setupData(data: model)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ListProductViewController: UICollectionViewDelegate {
    struct ConstantsSize {
        static let minimumLineSpacing = 11.0
        static let minimumInteritem = 11.0
        static let countItem = 2.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

extension ListProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing = ConstantsSize.minimumLineSpacing
        let countItem = ConstantsSize.countItem
        let withd = (collectionView.frame.width - itemSpacing) / countItem
        return CGSize(width: withd, height: 228)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        ConstantsSize.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        ConstantsSize.minimumInteritem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}


//MARK: - UISearchResultsUpdating
extension ListProductViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

//MARK: - life cycle viewContoller methods
extension ListProductViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}
