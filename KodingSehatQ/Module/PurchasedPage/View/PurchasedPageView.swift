//  
//  PurchasedPageView.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit
import RealmSwift

class PurchasedPageView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!

    // VARIABLES HERE
    var viewModel = PurchasedPageViewModel()
    var products = [Products]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 20, right: 0)
        tableView.backgroundColor = UIColor.white
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        
        tableView.register(UINib(nibName: ListProductsTableViewCell.reusableIndentifer, bundle: nil), forCellReuseIdentifier: ListProductsTableViewCell.reusableIndentifer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavbar()
    }
    
    func setupNavbar() {
        navigationItem.title = "Riwayat Pembelian"
        navigationController?.navigationBar.prefersLargeTitles = false
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
        
        if let allProduct = Database.shared.get(type: Products.self) {
            self.products = Array(allProduct)
            self.tableView.reloadData()
        }

    }
    
}

extension PurchasedPageView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListProductsTableViewCell.reusableIndentifer, for: indexPath) as? ListProductsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupPurchased(self.products[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            Database.shared.delete(object: self.products[indexPath.row])
            setupViewModel()
        }
    }
    
}

