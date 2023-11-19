//
//  AppCoordinator.swift
//  ProductsApp
//
//  Created by anjella on 18/11/23.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        openRootViewController()
    }
    
    fileprivate func openRootViewController() {
        window?.rootViewController = UINavigationController(rootViewController: MainTabBarController())
    }
}
