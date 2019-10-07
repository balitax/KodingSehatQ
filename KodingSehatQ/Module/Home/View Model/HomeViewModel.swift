//  
//  HomeViewModel.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel {

    private let service: HomeServiceProtocol

    private var model: [ProductPromo] = [ProductPromo]() {
        didSet {
            self.count = self.model.count
        }
    }
    
    private var category: [Category] = [Category]() {
        didSet {
            self.categoryCount = self.category.count
        }
    }

    /// Count your data in model
    var count: Int?
    var categoryCount: Int?

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    //MARK: -- UI Status

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    /// Define selected model
    var selectedObject: ProductPromo?
    
    func getItem(at index: IndexPath) -> ProductPromo? {
        if !model.isEmpty {
            return self.model[index.row]
        } else {
            return nil
        }
    }
    
    func getCategoryItem(at index: IndexPath) -> Category? {
        if !category.isEmpty {
            return self.category[index.row]
        } else {
            return nil
        }
    }

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetCategory: (() -> ())?

    init(withHome serviceProtocol: HomeServiceProtocol = HomeService() ) {
        self.service = serviceProtocol
    }
    
    func getProduct(completion: @escaping() -> Void) {
        self.isLoading = true
        self.service.getProductList(onSuccess: { products in
            self.isLoading = false
            if let promo = products[0].data?.productPromo,
                let getCategory = products[0].data?.category {
                self.model = promo
                self.category = getCategory
            }
            self.didGetCategory?()
            completion()
        }) { error in
            self.isLoading = false
            self.alertMessage = error
        }
    }
    
}
