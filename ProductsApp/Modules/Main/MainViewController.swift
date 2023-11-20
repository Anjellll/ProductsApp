//
//  MainViewController.swift
//  ProductsApp
//
//  Created by anjella on 20/11/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    var mainPresenter: MainPresenterDelegate?
    
    private let search: UISearchBar = {
        let search = UISearchBar()
        search.searchTextField.placeholder = "Search products by Name"
        search.searchTextField.textAlignment = .left
        search.searchTextField.font = .systemFont(ofSize: 16, weight: .light)
        search.barTintColor = .systemGray6
        search.tintColor = .red
        search.searchTextField.textColor = .darkGray
        search.layer.cornerRadius = 10.0
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor.systemGray3.cgColor
        search.clipsToBounds = true
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
}

extension MainViewController {
    private func setupUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(search)
    }
    
    private func setupConstraints() {
        search.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(80)
            maker.left.equalToSuperview().offset(16)
            maker.right.equalToSuperview().offset(-16)
            maker.height.equalTo(40)
        }
    }
}

extension MainViewController: MainControllerDelegate {
    
}


extension MainViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        
    }
}
