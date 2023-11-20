//
//  CartViewController.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class CartViewController: UIViewController {

    var cartPresenter: CartPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        navigationItem.title = "Cart"
    }
}

extension CartViewController: CartControllerDelegate {
    
}
