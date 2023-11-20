//
//  MainViewController.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit

class MainViewController: UIViewController {

    var mainPresenter: MainPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        navigationItem.title = "Main"
    }
}

extension MainViewController: MainControllerDelegate {
    
}
