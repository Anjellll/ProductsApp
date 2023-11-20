//
//  MainTabBarController.swift
//  ProductsApp
//
//  Created by anjella on 19/11/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .white
    }

    private func setupTabBar() {
        let mainViewController = MainModuleConfigurator.build()
        mainViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "main")?.withRenderingMode(.alwaysOriginal).resize(to: CGSize(width: SizeConstants.taBarIconWidth, height: SizeConstants.tabBarIconHeight)), selectedImage: UIImage(named: "selectedMain")?.withRenderingMode(.alwaysOriginal).resize(to: CGSize(width: SizeConstants.taBarIconWidth, height: SizeConstants.tabBarIconHeight)))
        mainViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let cartViewController =  CartConfigurator.build()
        cartViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal).resize(to: CGSize(width: SizeConstants.taBarIconWidth, height: SizeConstants.tabBarIconHeight)), selectedImage:UIImage(named: "selectedCart")?.withRenderingMode(.alwaysOriginal).resize(to: CGSize(width: SizeConstants.taBarIconWidth, height: SizeConstants.tabBarIconHeight)))
        cartViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)

        let favoritesViewController =  FavoriteConfigurator.build()
        favoritesViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "favorites")?.withRenderingMode(.alwaysOriginal).resize(to: CGSize(width: SizeConstants.taBarIconWidth, height: SizeConstants.tabBarIconHeight)), selectedImage: UIImage(named: "selectedFavorites")?.withRenderingMode(.alwaysOriginal).resize(to: CGSize(width: SizeConstants.taBarIconWidth, height: SizeConstants.tabBarIconHeight)))
        favoritesViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let profileViewController =  ProfileConfigurator.build()
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal).resize(to: CGSize(width: SizeConstants.taBarIconWidth, height: SizeConstants.tabBarIconHeight)), selectedImage: UIImage(named: "selectedProfile")?.withRenderingMode(.alwaysOriginal).resize(to: CGSize(width: SizeConstants.taBarIconWidth, height: SizeConstants.tabBarIconHeight)))
        profileViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        viewControllers = [mainViewController, cartViewController, favoritesViewController, profileViewController]
        selectedIndex = 0
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = true
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    private func createControllers(
         for rootViewController: UIViewController,
         image: UIImage
     ) -> UIViewController {
         let navVC = UINavigationController(rootViewController: rootViewController)
         navVC.tabBarItem.image = image
         return navVC
     }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

