//
//  FeedVC.swift
//  socialapp
//
//  Created by Hannan Saleemi on 04/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func signOutTapped(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)      //Remove key from KEYCHAIN fro autologin
        try! FIRAuth.auth()?.signOut()                              //Sign out of Firebase
        performSegue(withIdentifier: "goToSignIn", sender: nil)     //Back to Login Screen
        
    }

}
