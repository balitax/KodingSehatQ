//  
//  LoginView.swift
//  KodingSehatQ
//
//  Created by Agus Cahyono on 06/10/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginView: UIViewController {
    

    // OUTLETS HERE
    @IBOutlet weak var txUsername: UITextField!
    @IBOutlet weak var txPassword: UITextField!

    // VARIABLES HERE

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapFacebookLogin(_ sender: UIButton) {
        self.didUserLogin()
    }
    
    @IBAction func didTapGoogleLogin(_ sender: UIButton) {
        self.didUserLogin()
    }
    
    @IBAction func didTapUserLogin(_ sender: UIButton) {
        self.didUserLogin()
    }
    
    fileprivate func didUserLogin() {
        AppRouter.presentHome(from: self)
    }
    
}
