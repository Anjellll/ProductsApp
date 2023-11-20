//
//  ProductCollectionViewCell.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    private lazy var productImage: UIImageView! = {
        var productImage = UIImageView()
        productImage.contentMode = .scaleAspectFit
        productImage.clipsToBounds = true
        productImage.layer.shadowOffset = .init(width: 15, height: 10)
        productImage.layer.shadowOpacity = 0.4
        productImage.layer.shadowColor = UIColor.gray.cgColor
        return productImage
    }()
    
    private lazy var productLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir Next Bold", size: 15)
        return label
    }()
}
