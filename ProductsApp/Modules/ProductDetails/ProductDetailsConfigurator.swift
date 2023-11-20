//
//  ProductDetailsConfigurator.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class ProductDetailsConfigurator {
    static func build() -> UIViewController {
        let vc = ProductDetailsViewController()
//        let service = NetworkLayer()
        let presenter = ProductDetailsPresenter()
        
        vc.productDetailsPresenter = presenter
        
//        presenter.networkLayerDelegate = service
        presenter.view = vc
        
        return vc
    }
}
