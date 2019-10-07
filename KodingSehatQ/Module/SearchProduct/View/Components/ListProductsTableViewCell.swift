//
//  ListProductsTableViewCell.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class ListProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSearch(_ data: SearchProduct) {
        self.imgProduct.image = UIImage(named: data.productImage ?? "")
        self.productName.text = data.productName
        self.productPrice.text = data.productPrice
    }
    
    func setupPurchased(_ data: Products) {
        if let imageProduct = data.productImage {
            if let urlProduct = URL(string: imageProduct) {
                self.imgProduct.kf.setImage(with: urlProduct)
            }
        }
        self.productName.text = data.productName
        self.productPrice.text = data.productPrice
    }
    
}


extension ListProductsTableViewCell {
    class var reusableIndentifer: String { return String(describing: self) }
}
