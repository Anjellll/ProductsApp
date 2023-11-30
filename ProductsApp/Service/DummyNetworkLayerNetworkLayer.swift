//
//  DummyNetworkLayer.swift
//  ProductsApp
//
//  Created by anjella on 28/11/23.
//

import Foundation
import Alamofire

enum DummyApiType {
    
    // MARK: - GET
    case getAllProduсts
    case getAllHundredProducts
    case getSingleProduct(id: Int)
    case searchProducts(query: String)
    case getAllProductCategories
    case getProductCategory
    
    // MARK: - DELETE
    case deleteProduct(id: Int)
    
    var host: String {
        "dummyjson.com"
    }
    
    var path: String {
        switch self {
        case .getAllProduсts:
            return "/products"
        case .getAllHundredProducts:
            return "/products?limit=100&skip=0"
        case .getSingleProduct(let id):
            return "/products/\(id)"
        case .searchProducts(let query):
            return "/products/search?q=\(query)"
        case .getAllProductCategories:
            return "/products/categories"
        case .getProductCategory:
            return "/products/category/smartphones"
        case .deleteProduct(let id):
            return "/products/\(id)"
        }
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        return components
    }
}

final class DummyNetworkLayer {

    static let shared = DummyNetworkLayer()

    init() { }
}
 
extension DummyNetworkLayer: MainNetworkProtocol {
    func fetchAllProducts(apiType: DummyApiType, completion: @escaping (Result<AllProductsModel, Error>) -> Void) {
        let url = apiType.components.url!
        
        AF.request(url).validate().responseDecodable(of: AllProductsModel.self) { response in
            switch response.result {
            case .success(let allProducts):
                completion(.success(allProducts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchAllProducts(apiType: DummyApiType, limit: Int, skip: Int, completion: @escaping (Result<AllProductsModel, Error>) -> Void) {
        var components = apiType.components
        
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "skip", value: String(skip))
        ]
        
        guard let url = components.url else {
            // Обработка ошибки неверного URL
            return
        }
        
        AF.request(url).validate().responseDecodable(of: AllProductsModel.self) { response in
            switch response.result {
            case .success(let allProducts):
                completion(.success(allProducts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}



//final class DummyNetworkLayer {
//
//    static let shared = DummyNetworkLayer()
//
//    init() { }
//
//    private func getModel<T: Codable>(url: URL, completion: @escaping (Result<T, AFError>) -> ()) {
//        AF.request(url)
//            .validate()
//            .response { response in
//                switch response.result {
//                case .success(let data):
//                    if let model: T = DecodeHelper.decodeDataToObject(data: data) {
//                        completion(.success(model))
//                    }
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//
//    private func getModels<T: Codable>(url: URL, completion: @escaping (Result<[T], AFError>) -> ()) {
//        print(url)
//        AF.request(url)
//            .validate()
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    if let model: [T] = DecodeHelper.decodeDataToObject(data: data) {
//                        completion(.success(model))
//                    }
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//}
//
//
//extension DummyNetworkLayer: MainNetworkProtocol {
//    func fetchAllProducts(completion: @escaping (Result<[Product], AFError>) -> ()) {
//            guard let url = DummyApiType.getAllProduсts.components.url else {
//                // Handle URL creation error
//                return
//            }
//
//        DummyNetworkLayer.shared.getModels(url: url, completion: completion)
//        }
//}
