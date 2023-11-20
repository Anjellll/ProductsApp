//
//  MainViewController.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit
import SnapKit
import Kingfisher

class MainViewController: UIViewController {

    var mainPresenter: MainPresenterDelegate?
    
    private var productsData = [
        ProductsCategoryModels(categoryImage: "product1", categoryName: "Product1"),
        ProductsCategoryModels(categoryImage: "product2", categoryName: "Product2"),
        ProductsCategoryModels(categoryImage: "product3", categoryName: "Product3"),
        ProductsCategoryModels(categoryImage: "product1", categoryName: "Product4"),
        ProductsCategoryModels(categoryImage: "product2", categoryName: "Product5"),
        ProductsCategoryModels(categoryImage: "product3", categoryName: "Product6")
    ]
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchTextField.placeholder = "Search products by Name"
        search.searchTextField.textAlignment = .left
        search.searchTextField.font = .systemFont(ofSize: 16, weight: .light)
        search.barTintColor = .systemGray6
        search.tintColor = .red
        search.searchTextField.textColor = .darkGray
        search.searchTextField.backgroundColor = .systemGray6
        search.layer.cornerRadius = 10.0
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor.systemGray3.cgColor
        search.clipsToBounds = true
        return search
    }()
    
    private lazy var  categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        return collectionView
    }()
    
//    private let productsCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return collectionView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
}

extension MainViewController {
    private func setupUI() {
        setupSubviews()
        setupConstraints()
        configureCollectionViews()
    }
    
    private func setupSubviews() {
        view.addSubview(searchBar)
        view.addSubview(categoryCollectionView)
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(80)
            maker.left.equalToSuperview().offset(16)
            maker.right.equalToSuperview().offset(-16)
            maker.height.equalTo(40)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(15)
            make.width.equalTo(UIScreen.main.bounds.width) // ?
            make.height.equalTo(120)
            make.width.equalTo(60)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureCollectionViews() {
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.backgroundColor = .red
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier,
            for: indexPath) as? CategoryCollectionViewCell else { fatalError() }
        
        let categoryProduct = productsData[indexPath.row]
        cell.displayInfo(product: categoryProduct)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 8
     }
}


extension MainViewController: MainControllerDelegate {
    
}


extension MainViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        
    }
}
