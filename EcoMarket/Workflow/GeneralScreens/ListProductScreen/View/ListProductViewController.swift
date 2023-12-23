//
//  ListProductViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 15/12/23.
//

import UIKit

class LoadView: UIView {
    private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .mainGreen
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isHidden = false
        backgroundColor = .white
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

class ListProductViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let view = UISearchController()
        view.searchResultsUpdater = self
        view.searchBar.searchBarStyle = .minimal
        view.delegate = self
        view.searchBar.placeholder = "Быстрый поиск"
        return view
    }()
    
    private let customSegmentControl = CustomSegmentedControl("Все", "Фрукты", "Сухофрукты", "Зелень","Овощи", "Чай кофе", "Молочные продукты")

    private lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let loadView = LoadView()
    
    private let categories = ["Все", "Фрукты", "Сухофрукты", "Зелень","Овощи", "Чай кофе", "Молочные продукты"]
    
    var selectedCategoryIndex: String? {
        didSet {
            setupData()
        }
    }
    
    private var products: [Product] = [] {
        didSet {
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }
    }
    
    private var filterProducts: [Product] = [] {
        didSet {
            setupCollectionViewWhenEmty()
            self.productCollectionView.reloadData()
        }
    }
    
    private var filter: Bool = false
    
    private var checkPrice = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setupSegment() {
        customSegmentControl.delegate = self
        let index = categories.firstIndex(where: { $0 == selectedCategoryIndex} )
        customSegmentControl.firstSelectedSegment(tag: index ?? 0)
    }

    private func setup() {
        setupView()
        setupConstraints()
        setupNavigationContoller()
        setupSegment()
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
            customSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            customSegmentControl.heightAnchor.constraint(equalToConstant: 27),
            
            productCollectionView.topAnchor.constraint(equalTo: customSegmentControl.bottomAnchor, constant: 14),
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
    
    private func setupCollectionViewWhenEmty() {
        productCollectionView.backgroundView = (filterProducts.isEmpty && filter) ? EmtyView() : nil
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

//MARK: - CustomSegmentedControlDelegate
extension ListProductViewController: CustomSegmentedControlDelegate {
    func segmentTitle(title: String) {
        selectedCategoryIndex = title
    }
}

//MARK: - ProductCollectionViewCellDelegate
extension ListProductViewController: ProductCollectionViewCellDelegate {
    func sendToBusket(count: Int, id: Int) {
        if let index = products.firstIndex(where: { id ==  $0.id }) {
            if products[index].count != nil {
                products[index].count! += count
            } else {
                products[index].count = 1
            }
            busket()
            //checkPrice = (products[index].count ?? 1) * Int((Double(products[index].price) ?? 1.0))
        }
    }
    
    func busket() {
        let result = products.filter({ $0.count != nil })
        var cost = 0
        result.forEach({
            cost += ($0.count ?? 1) * Int((Double($0.price) ?? 1.0))
        })
        print(cost)
    }
}

//MARK: - UICollectionViewDataSource
extension ListProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filter ? filterProducts.count : products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = filter ? filterProducts[indexPath.row] : products[indexPath.row]
        cell.setupData(data: model)
        cell.delegate = self
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
        //filterProducts = products.filter({$0.title.contains(sear)})
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
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
        guard let text = searchController.searchBar.text, text.isEmpty == false else {
            self.filter = false
            filterProducts = []
            return
        }
        filter = true
        //productCollectionView.backgroundView = LoadView()
        self.filterProducts = self.products.filter({ $0.title.contains(text) })
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.productCollectionView.backgroundView = nil
//            self.filterProducts = self.products.filter({ $0.title.contains(text) })
//        }
    }
}

//MARK: - UISearchControllerDelegate
extension ListProductViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        if let cancelButton = searchController.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Отмена", for: .normal)
        }
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

