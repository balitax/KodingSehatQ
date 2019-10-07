//  
//  SearchProductView.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class SearchProductView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!

    // VARIABLES HERE
    var viewModel = SearchProductViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var filterProduct = [SearchProduct]()
    var isFilterActive = false
    private var throttler: Throttler? = nil
    
    public var throttlingInterval: Int? = 0 {
        didSet {
            guard let interval = throttlingInterval else {
                self.throttler = nil
                return
            }
            self.throttler = Throttler(seconds: Int(interval))
        }
    }

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
        
        tableView.register(UINib(nibName: ListProductsTableViewCell.reusableIndentifer, bundle: nil), forCellReuseIdentifier: ListProductsTableViewCell.reusableIndentifer)
        
        definesPresentationContext = true
        
        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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

    }
    
}


extension SearchProductView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterActive {
             return self.filterProduct.count
        } else {
             return SearchProduct.generateDummy().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListProductsTableViewCell.reusableIndentifer, for: indexPath) as? ListProductsTableViewCell else {
            return UITableViewCell()
        }
        
    
        if isFilterActive {
            cell.setupSearch(self.filterProduct[indexPath.row])
        } else {
            cell.setupSearch(SearchProduct.generateDummy()[indexPath.row])
        }
        
        return cell
        
    }
    
    func filterProducts(for searchText: String) {
         self.filterProduct = SearchProduct.generateDummy().filter({ (data: SearchProduct) -> Bool in
            return data.productName?.lowercased().range(of: searchText.lowercased()) != nil
       })
       
       self.tableView.reloadData()
    }
    
}

extension SearchProductView:  UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFilterActive = false
        self.tableView.reloadData()
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.tableView.reloadData()
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.isFilterActive = true
            
            guard let throttler = self.throttler else {
                self.filterProducts(for: searchText)
                return
            }
            throttler.throttle {
                DispatchQueue.main.async {
                     self.filterProducts(for: searchText)
                }
            }
           
        }
    }

}
