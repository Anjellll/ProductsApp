//
//  FavoriteViewController.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class FavoriteViewController: UIViewController {

    var favoritePresenter: FavoritePresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        navigationItem.title = "Favorite"
    }
}

extension FavoriteViewController: FavoriteControllerDelegate {
    
}
