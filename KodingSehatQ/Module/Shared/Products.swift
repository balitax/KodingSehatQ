//
//  Products.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation
import RealmSwift


class Products: Object, NSCopying {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var productImage: String?
    @objc dynamic var productDesc: String?
    @objc dynamic var productPrice: String?
    @objc dynamic var productLove: Bool = false
    @objc dynamic var productName: String?
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Products(value: self)
    }
    
    
}
