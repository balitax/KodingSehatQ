//
//  HeaderProductTableViewCell.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class HeaderProductTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var favoriteButton: FaveButton!
    @IBOutlet weak var titleProduct: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setHeader(_ data: ProductPromo) {
        
        if let imageProduct = data.imageURL {
            if let urlProduct = URL(string: imageProduct) {
                self.imgProduct.kf.setImage(with: urlProduct)
            }
        }
        
        
        if let isFavorite = data.loved {
            if isFavorite == 0 {
                self.favoriteButton.setSelected(selected: false, animated: true)
            } else {
                self.favoriteButton.setSelected(selected: true, animated: true)
            }
        }
        
        self.titleProduct.text = data.title
        
    }
    
}


extension HeaderProductTableViewCell {
    class var reusableIndentifer: String { return String(describing: self) }
}
