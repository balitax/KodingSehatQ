//
//  BaseTabBarView.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 07/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

class BaseTabBarView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabbarItem()
    }
    
    func addTabbarItem() {
        
        self.tabBar.tintColor = UIColor.darkGray
        self.tabBar.backgroundColor = .white
        
        let homeview = HomeView()
        let homePage = UINavigationController(rootViewController: homeview)
        homePage.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home_icon"), tag: 0)
        
        let feedView = UIViewController()
        feedView.view.backgroundColor = .white
        feedView.title = "Feeds"
        let feedPage = UINavigationController(rootViewController: feedView)
        feedPage.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed_icon"), tag: 1)
        
        let cartView = PurchasedPageView()
        let cartPage = UINavigationController(rootViewController: cartView)
        cartPage.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cart_icon"), tag: 2)
        
        let profileView = UIViewController()
        profileView.view.backgroundColor = .white
        profileView.title = "Profile"
        let profilePage = UINavigationController(rootViewController: profileView)
        profilePage.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_icon"), tag: 3)
        
        self.viewControllers = [homePage, feedPage, cartPage, profilePage]
        
    }

}
