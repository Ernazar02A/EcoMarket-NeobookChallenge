//
//  HomeViewController.swift
//  EcoMarket
//
//  Created by Ernazar on 14/12/23.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var foodCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return view
    }()
    
    var presenter: HomePresenterProtocol!
    
    override func setup() {
        super.setup()
        setupNavigationTitle()
        presenter = HomePresenter(view: self, model: HomeModel())
    }
    
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Эко маркет"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    override func setupView() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2123982906, green: 0.2327036262, blue: 0.2559677958, alpha: 1)
        view.addSubview(foodCategoryCollectionView)
        foodCategoryCollectionView.frame = view.bounds
    }
}

//MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func reloadData() {
        foodCategoryCollectionView.reloadData()
    }
}


//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.countCategorys
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            print("find nil CategoryCollectionViewCell")
            return UICollectionViewCell()
        }
        let model = presenter.getCategory(indexPath)
        cell.setupData(model)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(presenter.getNameCategory(indexPath))
        let vc = ListProductViewController()
        vc.selectedCategoryIndex = presenter.getCategory(indexPath).name
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    private struct LayoutConstants {
        static let totalHorizontalPadding: CGFloat = 43
        static let numberOfItemsPerRow: CGFloat = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = LayoutConstants.totalHorizontalPadding
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / LayoutConstants.numberOfItemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        11
    }
}
