//
//  AllProductsModel.swift
//  ProductsApp
//
//  Created by anjella on 28/11/23.
//

import Foundation

// MARK: - AllProductsModel
struct AllProductsModel: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category: String?
    let thumbnail: String?
    let images: [String]?
    // ---------------------
    let isDeleted: Bool?
    let deletedOn: String?
}
