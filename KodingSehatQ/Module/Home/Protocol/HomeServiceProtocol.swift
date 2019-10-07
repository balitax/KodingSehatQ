//  
//  HomeServiceProtocol.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation

protocol HomeServiceProtocol {

    
    /// Get Product
    /// - Parameter onSuccess: onSuccess description
    /// - Parameter onFailure: onFailure description
    func getProductList(onSuccess: @escaping(_ data: ProductResponse) -> Void, onFailure: @escaping(String) -> Void)
    
}
