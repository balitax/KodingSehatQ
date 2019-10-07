//
//  CategoryItemsCollectionViewCell.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class CategoryItemsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var titleCategory: UILabel!
    
    var loading = LoadingPlaceholderView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loading.cover(self)
        self.imgCategory.layer.cornerRadius = self.imgCategory.frame.size.width / 2
    }
    
    func setupData(_ data: Category?) {
        
        if let imageProduct = data?.imageURL {
            if let urlProduct = URL(string: imageProduct) {
                self.imgCategory.kf.setImage(with: urlProduct)
            }
        }
        
        self.titleCategory.text = data?.name
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loading.uncover()
        }
        
    }
    
}

extension CategoryItemsCollectionViewCell {
    class var reusableIndentifer: String { return String(describing: self) }
}
