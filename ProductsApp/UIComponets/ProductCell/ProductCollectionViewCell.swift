//
//  ProductCollectionViewCell.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    var isLiked: Bool = false
    
    private lazy var productImage: UIImageView = {
        var productImage = UIImageView()
        productImage.contentMode = .scaleAspectFill
        productImage.clipsToBounds = true
        productImage.layer.shadowColor = UIColor.gray.cgColor
        return productImage
    }()
    
    private lazy var productLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()

    private lazy var productPrice: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()

    private lazy var productBrand: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor =  .gray
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()

    private lazy var productRaiting: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()

    private lazy var productRaitingImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "starRaiting")
        return image
    }()

    private lazy var productDiscount: UILabel = {
       var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor =  .white
        label.backgroundColor = .systemPink
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "redHeart"), for: .normal)
        button.contentMode = .center
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func likeButtonTapped() {
        print("likeButtonTapped")
        isLiked.toggle()
        let imageName = isLiked ? "filledHeart" : "redHeart"
        let image = UIImage(named: imageName)
        likeButton.setImage(image, for: .normal)
    }
}

extension ProductCollectionViewCell {
    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(productImage)
        addSubview(productLabel)
        addSubview(productRaitingImage)
        addSubview(productRaiting)
        addSubview(productBrand)
        addSubview(productPrice)
        addSubview(productDiscount)
        addSubview(likeButton)
    }
    
    private func setupConstraints() {
        productImage.snp.makeConstraints{ maker in
            maker.top.equalToSuperview()
            maker.left.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.height.equalTo(194)
            maker.width.equalTo(387)
        }
        
        likeButton.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(13)
            maker.height.width.equalTo(26)
            maker.right.equalToSuperview().offset(-20)
        }
        
        productLabel.snp.makeConstraints { maker in
            maker.top.equalTo(productImage.snp.bottom).offset(10)
            maker.left.equalToSuperview().offset(15)
            maker.height.equalTo(31)
            maker.width.equalTo(150)
        }

        productPrice.snp.makeConstraints { maker in
            maker.top.equalTo(productImage.snp.bottom).offset(10)
            maker.left.equalTo(productLabel.snp.right).offset(20)
            maker.height.equalTo(31)
            maker.width.equalTo(80)
        }

        
        productRaitingImage.snp.makeConstraints { maker in
            maker.top.equalTo(productLabel.snp.bottom).offset(8)
            maker.left.equalToSuperview().inset(10)
            maker.height.width.equalTo(18)
        }

        productRaiting.snp.makeConstraints { maker in
            maker.top.equalTo(productLabel.snp.bottom).offset(8)
            maker.left.equalToSuperview().inset(32)
            maker.height.equalTo(20)
            maker.width.equalTo(70)
            maker.centerY.equalTo(productRaitingImage.snp.centerY)
        }

        productBrand.snp.makeConstraints { maker in
            maker.top.equalTo(productLabel.snp.bottom).offset(8)
            maker.left.equalTo(productRaiting.snp.right).offset(14)
            maker.height.equalTo(20)
            maker.width.equalTo(150)
            maker.centerY.equalTo(productRaitingImage.snp.centerY)
        }

        productDiscount.snp.makeConstraints { maker in
            maker.right.equalToSuperview().offset(-10)
            maker.height.equalTo(31)
            maker.width.equalTo(60)
            maker.centerY.equalTo(productLabel.snp.centerY)
        }
    }
    
    func displayInfo(product: Product) {
        productLabel.text = product.title
        if let price = product.price {
            productPrice.text = String("\(price)$")
        } else {
            productPrice.text = "N/A"
        }
        
        if let brand = product.brand {
            productBrand.text = String("•  \(brand)")
        }
        
        if let raiting = product.rating {
            productRaiting.text = String("\(raiting)(101)")
        } else {
            productRaiting.text = "N/A"
        }
        
        if let discount = product.discountPercentage {
            productDiscount.text = String("\(discount)%")
        } else {
            productDiscount.text = "N/A"
        }
        
        if let thumbnailURLString = product.thumbnail,
           let thumbnailURL = URL(string: thumbnailURLString) {
            productImage.kf.setImage(with: thumbnailURL, placeholder: UIImage(named: "placeholderImage"))
        } else {
            productImage.image = UIImage(named: "placeholderImage")
        }
    }
}
