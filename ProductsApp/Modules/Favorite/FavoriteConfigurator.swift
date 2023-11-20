//
//  FavoriteConfigurator.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class FavoriteConfigurator {
    static func build() -> UIViewController {
        let vc = FavoriteViewController()
//        let service = NetworkLayer()
        let presenter = FavoritePresenter()
        
        vc.favoritePresenter = presenter
        
//        presenter.networkLayerDelegate = service
        presenter.view = vc
        
        return vc
    }
}
