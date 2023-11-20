//
//  CartConfigurator.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class CartConfigurator {
    static func build() -> UIViewController {
        let vc = CartViewController()
        let presenter = CartPresenter()
        
        vc.cartPresenter = presenter
        
        presenter.view = vc
        
        return vc
    }
}
