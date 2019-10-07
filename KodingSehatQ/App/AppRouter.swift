//
//  AppRouter.swift
//  BritaAja
//
//  Created by Agus Cahyono on 18/09/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class AppRouter {
    
    static func presentRootScreen(in window: UIWindow?) {
        window?.makeKeyAndVisible()
        window?.rootViewController = LoginView()
    }
    
    static func presentHome(from view: UIViewController) {
        let home = BaseTabBarView()
        home.modalPresentationStyle = .overFullScreen
        view.present(home, animated: true, completion: nil)
    }
    
    static func presentSearchScreen(from view: UIViewController) {
        let search = SearchProductView()
        search.hidesBottomBarWhenPushed = true
        view.navigationController?.pushViewController(search, animated: true)
    }
    
    static func presentPurchasedProductScreen(from view: UIViewController) {
        let purchased = PurchasedPageView()
        purchased.hidesBottomBarWhenPushed = true
        view.navigationController?.pushViewController(purchased, animated: true)
    }
    
    static func presentDetailProduct(from view: UIViewController, with data: ProductPromo) {
        let detail = DetailProductView()
        detail.promo = data
        detail.hidesBottomBarWhenPushed = true
        view.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
