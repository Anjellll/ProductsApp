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
    
    private var productsCategoryData = [
        ProductsCategoryModels(categoryImage: "product1", categoryName: "Product1"),
        ProductsCategoryModels(categoryImage: "product2", categoryName: "Product2"),
        ProductsCategoryModels(categoryImage: "product3", categoryName: "Product3"),
        ProductsCategoryModels(categoryImage: "product1", categoryName: "Product4"),
        ProductsCategoryModels(categoryImage: "product2", categoryName: "Product5"),
        ProductsCategoryModels(categoryImage: "product3", categoryName: "Product6")
    ]
    
    private var productData = [
        ProductModel(title: "IPhoneX", description: nil, price: 1000, brand: "Apple", discountPercentage: 12.5, rating: 4.6, thumbnail: "phone1"),
        ProductModel(title: "MacBook", description: nil, price: 2000, brand: "Apple", discountPercentage: 12.2, rating: 4.4, thumbnail: "macbook"),
        ProductModel(title: "Airpods Pro", description: nil, price: 1200, brand: "Apple", discountPercentage: 32.2, rating: 3.6, thumbnail: "airpods"),
        ProductModel(title: "IPhoneX", description: nil, price: 1000, brand: "Apple", discountPercentage: 12.5, rating: 4.6, thumbnail: "phone1"),
        ProductModel(title: "MacBook", description: nil, price: 2000, brand: "Apple", discountPercentage: 12.2, rating: 4.4, thumbnail: "macbook"),
        ProductModel(title: "Airpods Pro", description: nil, price: 1200, brand: "Apple", discountPercentage: 32.2, rating: 3.6, thumbnail: "airpods"),
    ]
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchTextField.placeholder = "Search products by name"
        search.searchTextField.textAlignment = .left
        search.searchTextField.font = .systemFont(ofSize: 16, weight: .light)
        search.barTintColor = .white
        search.tintColor = .systemPink
        search.searchTextField.textColor = .darkGray
        search.searchTextField.backgroundColor = .white
        search.layer.cornerRadius = 10.0
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor.systemGray4.cgColor
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
    
    private let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
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
        view.addSubview(productsCollectionView)
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
            make.height.equalTo(115)
            make.width.equalTo(80)
            make.leading.trailing.equalToSuperview()
        }
        
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(15)
            make.width.equalTo(UIScreen.main.bounds.width) // ?
            make.height.equalTo(200)
            make.width.equalTo(400)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        
    }
    
    private func configureCollectionViews() {
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        productsCollectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return productsCategoryData.count
        } else if collectionView == productsCollectionView {
            return productData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            guard let cell = categoryCollectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier,
                for: indexPath) as? CategoryCollectionViewCell else { fatalError() }
            
            let categoryProduct = productsCategoryData[indexPath.row]
            cell.displayInfo(product: categoryProduct)
            return cell
        } else if collectionView == productsCollectionView {
            // Создайте ячейку для второй коллекции и настройте ее
            // Пример:
            guard let cell = productsCollectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ProductCollectionViewCell else { fatalError() }
            
            let product = productData[indexPath.row]
            cell.displayInfo(product: product)
            return cell
        }
        
        // Этот код никогда не должен достигнуться
        fatalError("Unexpected collection view")
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
        } else if collectionView == productsCollectionView {
            // Верните размеры для ячейки второй коллекции
            // Пример:
            return CGSize(width: collectionView.frame.width, height: 260) // or change height to 230
        }
        
        // Этот код никогда не должен достигнуться
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryCollectionView {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        } else if collectionView == productsCollectionView {
            // Верните отступы для второй коллекции
            // Пример:
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
        
        // Этот код никогда не должен достигнуться
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView {
            return 8
        } else if collectionView == productsCollectionView {
            // Верните минимальный интервал между строками для второй коллекции
            // Пример:
            return 8
        }
        
        // Этот код никогда не должен достигнуться
        return 0
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
