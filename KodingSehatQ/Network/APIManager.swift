//
//  APIManager.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation
import Alamofire


protocol APIProtocol {
    var Request: APIManager.request { get }
}

class APIManager: NSObject {
    
    static var shared = APIManager()
    
    let baseURL = "https://private-4639ce-ecommerce56.apiary-mock.com/"
    private let headers = ["Content-Type": "application/json; charset=utf-8"]
    
    struct request {
        var url: String
        var method: HTTPMethod
    }
    
    public func req(_ Req: requestEnum,
                    params: [String: String]? = nil,
                    completion: @escaping (_ success: Bool, _ data: Data?) -> ()) {
        
        var parameters: [String: String] = [:]
        if let params = params {
            parameters = params
        }
        
        Alamofire.request(
            baseURL + Req.Request.url,
            method: Req.Request.method,
            parameters: parameters,
            headers: headers)
            .response { response in
                switch response.response?.statusCode ?? 404 {
                case 200..<300:
                    completion(true, response.data)
                case 400..<500:
                    completion(false, response.data)
                default:
                    break
                }
        }
    }
    
    public enum requestEnum : APIProtocol {
        case getProduct
        
        var Request : request {
            switch self {
            case .getProduct:
                return request(url: "home", method: .get)
            }
        }
    }
    
}

