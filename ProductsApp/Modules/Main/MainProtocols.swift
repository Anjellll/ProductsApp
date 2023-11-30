//
//  MainProtocols.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import Foundation
import Alamofire

protocol MainControllerDelegate: AnyObject {
    func updateView(with products: [Product])
    func showError(message: String)
}

protocol MainPresenterDelegate: AnyObject {
    func getAllProducts()
}

protocol MainNetworkProtocol: AnyObject {
    func fetchAllProducts(apiType: DummyApiType, completion: @escaping (Result<AllProductsModel, Error>) -> Void)
    func fetchAllProducts(apiType: DummyApiType, limit: Int, skip: Int, completion: @escaping (Result<AllProductsModel, Error>) -> Void)
}
