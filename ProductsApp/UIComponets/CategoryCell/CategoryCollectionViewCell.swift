//
//  CategoryCollectionViewCell.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    private lazy var categoryImage: UIImageView! = {
        var productImage = UIImageView()
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 80 / 2
        productImage.clipsToBounds = true
        productImage.layer.borderWidth = 0.7
        productImage.layer.borderColor = UIColor.gray.cgColor
        productImage.layer.shadowOffset = .init(width: 15, height: 10)
        productImage.layer.shadowOpacity = 0.4
        productImage.layer.shadowColor = UIColor.gray.cgColor
        return productImage
    }()

    private lazy var categoryLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionViewCell {
    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(categoryImage)
        addSubview(categoryLabel)
    }
    
    private func setupConstraints() {
        categoryImage.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(10)
            maker.left.equalToSuperview().offset(5)
            maker.right.equalToSuperview().offset(-5)
            maker.height.width.equalTo(80)
        }

        categoryLabel.snp.makeConstraints { maker in
            maker.top.equalTo(categoryImage.snp.bottom).offset(10)
            maker.centerX.equalTo(categoryImage.snp.centerX)
            maker.height.greaterThanOrEqualTo(15)
        }
    }

    
    func displayInfo(product: ProductsCategoryModels) {
        categoryLabel.text = product.categoryName
        
        if let imageName = product.categoryImage {
            categoryImage.image = UIImage(named: imageName)
        } else {
            categoryImage.image = UIImage(named: "placeholderImage")
        }
    }
}
