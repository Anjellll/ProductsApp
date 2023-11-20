//
//  ProductDetailsViewController.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    var productDetailsPresenter: ProductDetailsPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        navigationItem.title = "ProductDetails"
    }
}

extension ProductDetailsViewController: ProductDetailsControllerDelegate {
    
}
