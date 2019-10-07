//  
//  DetailProductView.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class DetailProductView: UIViewController {
    
    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textPrice: UILabel!
    @IBOutlet weak var btnBuyNow: UIButton!
    
    // VARIABLES HERE
    var viewModel = DetailProductViewModel()
    var promo: ProductPromo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 20, right: 0)
        tableView.backgroundColor = UIColor.white
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
        
        tableView.register(UINib(nibName: HeaderProductTableViewCell.reusableIndentifer, bundle: nil), forCellReuseIdentifier: HeaderProductTableViewCell.reusableIndentifer)
        tableView.register(UINib(nibName: ProductDescriptionTableViewCell.reusableIndentifer, bundle: nil), forCellReuseIdentifier: ProductDescriptionTableViewCell.reusableIndentifer)
        
        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavbar()
    }
    
    func setupNavbar() {
        navigationItem.title = promo?.title
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.didShareProduct(_:)))
        navigationItem.rightBarButtonItem = shareButton
        
    }
    
    fileprivate func setupViewModel() {
        
        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.textPrice.text = promo?.price ?? ""
        self.btnBuyNow.addTarget(self, action: #selector(self.didBuyProduct(_:)), for: .touchUpInside)
    }
    
    @objc func didShareProduct(_ sender: UIBarButtonItem) {
        let nameItem = promo?.title ?? ""
        let imageItem : NSURL = NSURL(string: promo?.imageURL ?? "")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [nameItem, imageItem], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = sender.customView
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

extension DetailProductView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderProductTableViewCell.reusableIndentifer, for: indexPath) as? HeaderProductTableViewCell else {
                return UITableViewCell()
            }
            
            if let promo = promo {
                cell.setHeader(promo)
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDescriptionTableViewCell.reusableIndentifer, for: indexPath) as? ProductDescriptionTableViewCell else {
                return UITableViewCell()
            }
            
            if let promo = promo {
                cell.productDescription.text = promo.productPromoDescription
            }
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    @objc func didBuyProduct(_ sender: UIButton) {
        
        let save = Products()
        save.id = Int.random(in: 1...9)
        save.productImage = promo?.imageURL
        save.productDesc = promo?.productPromoDescription
        save.productName = promo?.title
        save.productPrice = promo?.price
        save.productLove = (promo?.loved ?? 0) == 0 ? false : true
        Database.shared.save(object: save)
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "The product has been add to your cart", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
        
    }
    
}


