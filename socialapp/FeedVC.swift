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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {       //Sections mostly one
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {       //How many cells
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }

    
    @IBAction func signOutTapped(_ sender: UITapGestureRecognizer) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)      //Remove key from KEYCHAIN fro autologin
        try! FIRAuth.auth()?.signOut()                              //Sign out of Firebase
        performSegue(withIdentifier: "goToSignIn", sender: nil)     //Back to Login Screen
        
    }
}
