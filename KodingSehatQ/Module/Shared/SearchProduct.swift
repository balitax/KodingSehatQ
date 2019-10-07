//
//  SearchProduct.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation

struct SearchProduct {
    
    var id: Int = 0
    var productImage: String?
    var productPrice: String?
    var productLove: Bool = false
    var productName: String?
    
    static func generateDummy() -> [SearchProduct] {
        return [
            SearchProduct(id: 0, productImage: "gofood", productPrice: "$400", productLove: false, productName: "Ayam Bakar Madu Pak Slamet"),
            SearchProduct(id: 1, productImage: "gofood", productPrice: "$120", productLove: false, productName: "Bebek Bakar Kaleo Istimewa Sambel Bajak"),
            SearchProduct(id: 2, productImage: "gofood", productPrice: "$200", productLove: false, productName: "Sate Padang Original Ekstra Sambal Petis"),
            SearchProduct(id: 3, productImage: "gofood", productPrice: "$10", productLove: true, productName: "Nasi Padang Istimewa + Lele Bakar"),
            SearchProduct(id: 4, productImage: "", productPrice: "$250", productLove: false, productName: "Gurame Bakar Madu Khas Jawa Timur"),
            SearchProduct(id: 5, productImage: "gofood", productPrice: "$510", productLove: true, productName: "Ayam Bakar Madu 1 Ekor Full"),
            SearchProduct(id: 6, productImage: "gofood", productPrice: "$50", productLove: false, productName: "Bebek Bakar Biasa + Nasi"),
            SearchProduct(id: 7, productImage: "gofood", productPrice: "$10", productLove: false, productName: "Sambal Teri Istimewa + Nasi 1 Paket"),
            SearchProduct(id: 8, productImage: "gofood", productPrice: "$100", productLove: false, productName: "Ayam Panggang Sambel Pete"),
        ]
    }
    
}
