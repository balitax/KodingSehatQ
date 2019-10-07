//
//  ProductListsTableViewCell.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit
import Kingfisher

class ProductListsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var btnFavorite: FaveButton!
    
    
    var loading = LoadingPlaceholderView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loading.cover(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupProduct(_ data: ProductPromo?) {
        
        if let imageProduct = data?.imageURL {
            if let urlProduct = URL(string: imageProduct) {
                self.imgProduct.kf.setImage(with: urlProduct)
            }
        }
        
        if let isFavorite = data?.loved {
            if isFavorite == 0 {
                self.btnFavorite.setSelected(selected: false, animated: true)
            } else {
                self.btnFavorite.setSelected(selected: true, animated: true)
            }
        }
        
        self.productName.text = data?.title
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loading.uncover()
        }
    }
    
}

extension ProductListsTableViewCell {
    class var reusableIndentifer: String { return String(describing: self) }
}
