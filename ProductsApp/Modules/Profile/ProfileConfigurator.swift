//
//  ProfileConfigurator.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class ProfileConfigurator {
    static func build() -> UIViewController {
        let vc = ProfileViewController()
//        let service = NetworkLayer()
        let presenter = ProfilePresenter()
        
        vc.profilePresenter = presenter
        
//        presenter.networkLayerDelegate = service
        presenter.view = vc
        
        return vc
    }
}
