//
//  DynamicCollectionView.swift
//  pasarudang
//
//  Created by Agus Cahyono on 20/02/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

open class DynamicCollectionView: UICollectionView {
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
