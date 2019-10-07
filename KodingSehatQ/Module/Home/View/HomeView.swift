//  
//  HomeView.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class HomeView: UIViewController {
    
    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = HomeViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Produk Kami"
        
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Cari produk disini"
        
        definesPresentationContext = true
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            
        }
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 20, right: 0)
        tableView.backgroundColor = UIColor.white

        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)

        let categoryCell = UINib.init(nibName: "CategoryTableViewCell", bundle: Bundle.main)

        tableView.register(categoryCell, forCellReuseIdentifier: CategoryTableViewCell.reusableIndentifer)
        tableView.register(UINib(nibName: "ProductListsTableViewCell", bundle: nil), forCellReuseIdentifier: ProductListsTableViewCell.reusableIndentifer)

        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavbar()
    }
    
    func setupNavbar() {
        
        // add left barbutton
        let favoriteBarButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.didOpenPurchasedProduct(_:)))
        
        self.navigationItem.leftBarButtonItem = favoriteBarButton
        
    }
    
    @objc func didOpenPurchasedProduct(_ sender: UIBarButtonItem) {
        AppRouter.presentPurchasedProductScreen(from: self)
    }
    
    fileprivate func setupViewModel() {
        
        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                print("LOADING...")
            } else {
                print("DATA READY")
            }
        }
        
        self.viewModel.internetConnectionStatus = {
            print("Internet disconnected")
            // show UI Internet is disconnected
        }
        
        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }
        
        self.viewModel.getProduct {
            self.tableView.reloadData()
        }
        
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.viewModel.count ?? 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reusableIndentifer, for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }

            cell.delegate = self

            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListsTableViewCell.reusableIndentifer, for: indexPath) as? ProductListsTableViewCell else {
                return UITableViewCell()
            }

            cell.setupProduct(self.viewModel.getItem(at: indexPath))

            return cell
        default:
            return UITableViewCell()
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if let promo = self.viewModel.getItem(at: indexPath) {
                AppRouter.presentDetailProduct(from: self, with: promo)
            }
        }
    }

}


extension HomeView:  UISearchBarDelegate, CategoryProductDelegate {
    
    func didSelectedCategory(id: Int, name: String) {
        let alert = UIAlertController(title: "Kategori", message: name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let title = searchBar.text, title.isEmpty == false else {
            return
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        AppRouter.presentSearchScreen(from: self)
        return true
    }
    
    
}


