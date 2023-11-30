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
        ProductsCategoryModels(categoryImage: "smartphones", categoryName: "smartphones"),
        ProductsCategoryModels(categoryImage: "laptops", categoryName: "laptops"),
        ProductsCategoryModels(categoryImage: "fragrances", categoryName: "fragrances"),
        ProductsCategoryModels(categoryImage: "skincare", categoryName: "skincare"),
        ProductsCategoryModels(categoryImage: "groceries", categoryName: "groceries"),
        ProductsCategoryModels(categoryImage: "home-decoration", categoryName: "home-decoration"),
        ProductsCategoryModels(categoryImage: "furniture", categoryName: "furniture"),
        ProductsCategoryModels(categoryImage: "tops", categoryName: "tops"),
        ProductsCategoryModels(categoryImage: "womens-dresses", categoryName: "womens-dresses"),
        ProductsCategoryModels(categoryImage: "womens-shoes", categoryName: "womens-shoes"),
        ProductsCategoryModels(categoryImage: "mens-shirts", categoryName: "mens-shirts"),
        ProductsCategoryModels(categoryImage: "mens-shoes", categoryName: "mens-shoes"),
        ProductsCategoryModels(categoryImage: "mens-watches", categoryName: "mens-watches"),
        ProductsCategoryModels(categoryImage: "womens-watches", categoryName: "womens-watches"),
        ProductsCategoryModels(categoryImage: "womens-bags", categoryName: "womens-bags"),
        ProductsCategoryModels(categoryImage: "womens-jewellery", categoryName: "womens-jewellery"),
        ProductsCategoryModels(categoryImage: "sunglasses", categoryName: "sunglasses"),
        ProductsCategoryModels(categoryImage: "automotive", categoryName: "automotive"),
        ProductsCategoryModels(categoryImage: "motorcycle", categoryName: "motorcycle"),
        ProductsCategoryModels(categoryImage: "lighting", categoryName: "lighting")
    ]
    
    private var categoryProductData = [Product]()
    private var allProductsData = [Product]()
    
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
        search.layer.borderColor = UIColor.gray.cgColor
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
        getProducts()
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
    
    private func getProducts() {
        mainPresenter?.getAllProducts()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return productsCategoryData.count
        } else if collectionView == productsCollectionView {
            return allProductsData.count
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
            
            guard let cell = productsCollectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ProductCollectionViewCell else { fatalError() }
            
            let product = allProductsData[indexPath.row]
            cell.displayInfo(product: product)
            return cell
        }
        
        fatalError("Unexpected collection view")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let selectedCategory = productsCategoryData[indexPath.item].categoryName
            filterProductsByCategory(selectedCategory)
        }
    }

    private func filterProductsByCategory(_ category: String?) {
        guard let category = category else { return }

        print("Selected category: \(category)")
        allProductsData = category.isEmpty ? categoryProductData : categoryProductData.filter { $0.category == category }

        print("Filtered products count: \(allProductsData.count)")

        self.productsCollectionView.reloadData()
    }


}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
        } else if collectionView == productsCollectionView {
    
            return CGSize(width: collectionView.frame.width, height: 260) // or change height to 230
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoryCollectionView {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        } else if collectionView == productsCollectionView {
        
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
        
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView {
            return 8
        } else if collectionView == productsCollectionView {
            
            return 8
        }
        
        return 0
    }
}

extension MainViewController: MainControllerDelegate {
    func updateView(with products: [Product]) {
        self.allProductsData = products
        self.categoryProductData = products

        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
            self.categoryCollectionView.reloadData()
        }
    }
    
    func showError(message: String) {
        print("Error: \(message)")
    }
}


extension MainViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        // Фильтрация категорий
        let filteredCategories = productsCategoryData.filter { $0.categoryName?.lowercased().contains(searchText.lowercased()) ?? false }

        // Если есть выбранная категория
        if let selectedCategory = filteredCategories.first?.categoryName {
            // Фильтрация продуктов в выбранной категории
            allProductsData = categoryProductData.filter { $0.category == selectedCategory && ($0.title?.lowercased().contains(searchText.lowercased()) ?? false) }
        } else {
            // Если нет выбранной категории, отобразите все продукты
            allProductsData = categoryProductData.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false }
        }

        self.productsCollectionView.reloadData()
    }
}
