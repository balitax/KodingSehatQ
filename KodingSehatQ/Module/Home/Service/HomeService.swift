//  
//  HomeService.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation
import Alamofire

class HomeService: HomeServiceProtocol {

    func getProductList(onSuccess: @escaping (ProductResponse) -> Void, onFailure: @escaping (String) -> Void) {
        
        APIManager.shared.req(.getProduct, params: [:]) { isSuccess, data in
            
            if isSuccess {
                
                do {
                    let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data!)
                    onSuccess(productResponse)
                } catch {
                    onFailure("an error occured")
                }
                
            } else {
                onFailure("an error occured")
            }
            
        }
        
    }
    
}
