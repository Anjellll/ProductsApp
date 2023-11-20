//
//  MainModuleConfigurator.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class MainModuleConfigurator {
    static func build() -> UIViewController {
        let vc = MainViewController()
//        let service = NetworkLayer()
        let presenter = MainPresenter()
        
        vc.mainPresenter = presenter
        
//        presenter.networkLayerDelegate = service
        presenter.view = vc
        
        return vc
    }
}
