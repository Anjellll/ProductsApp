//
//  MainPresenter.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import Foundation
import Alamofire

class MainPresenter {
    weak var view: MainControllerDelegate?
    var networkManager: MainNetworkProtocol?
}

extension MainPresenter: MainPresenterDelegate {
    func getAllProducts() {
        networkManager?.fetchAllProducts(apiType: .getAllProduсts, limit: 100, skip: 0) { result in
            switch result {
            case .success(let allProducts):
                if let products = allProducts.products {
                    self.view?.updateView(with: products)
                }
            case .failure(let error):
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    
}
