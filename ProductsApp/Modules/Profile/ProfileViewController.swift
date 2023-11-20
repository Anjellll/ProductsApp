//
//  ProfileViewController.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class ProfileViewController: UIViewController {

    var profilePresenter: ProfilePresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        navigationItem.title = "Profile"
    }
}

extension ProfileViewController: ProfileControllerDelegate {
    
}
