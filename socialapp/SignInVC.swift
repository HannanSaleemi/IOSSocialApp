//
//  SignInVC.swift
//  socialapp
//
//  Created by Hannan Saleemi on 01/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

import UIKit
//fb sdks
import FBSDKCoreKit
import FBSDKLoginKit

import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {                         //Autherticate with facebook
        
        let facebookLogin = FBSDKLoginManager()                                                 //Create facebook manager
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in    //Ask to read email (get permission)
            
            if error != nil {                                                                  //IF THERE WAS AN ERROR
                print("////////////HANNAN: UNABLE TO AUTHENTICATE WITH FACEBOOK \(error)")
            }else if result?.isCancelled == true{                                               //IF USER CANCELS PERMISSIONS
                print("////////////USER CANCELLED AUTHENTICATION!!")
            }else{                                                                              //successful login and permission given
                print("Authenticated with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)    //Credentials
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    
    func firebaseAuth(_ credential: FIRAuthCredential) {                            //Authenticating with Firebase method
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in     //Authenticating with firebase
            
            if error != nil {                                                       //If there is an error
                print("////////HANNAN: Unable to authernticate with FIREBASE")
            }else{                                                                  //If successful authentication
                print("Hannan: Successfull autherticated with FIREBASE!!")
            }
            
        })
        
    }
    
    
}

