//
//  SignInVC.swift
//  socialapp
//
//  Created by Hannan Saleemi on 01/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

import UIKit
import Firebase
//fb sdks
import FBSDKCoreKit
import FBSDKLoginKit
//Swift Keychain Autologin
import SwiftKeychainWrapper

class SignInVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailField: FancyField!          //Emails Field
    @IBOutlet weak var passwordField: FancyField!       //Password Field
    
    @IBOutlet weak var redView: UIView!                 //Incorrect View
    @IBOutlet weak var incorrectLbl1: UILabel!          //Advice lbl 1
    @IBOutlet weak var incorrectLbl2: UILabel!          //Advice lbl 2
    @IBOutlet weak var incorrectLbl3: UILabel!          //advice lbl 3
    @IBOutlet weak var tryAgainBtn: UIButton!           //try again btn
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){        //IF Key exists in keychain
            performSegue(withIdentifier: "goToFeed", sender: nil)             //If key exists go straight to FeedVC without login
        }
    }
    
    
    @IBAction func tryAgainBtnTapped(_ sender: UIButton) {  //Incorrect View
        
        redView.isHidden = true
        incorrectLbl1.isHidden = true
        incorrectLbl2.isHidden = true
        incorrectLbl3.isHidden = true
        tryAgainBtn.isHidden = true
        
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
                if let user = user{
                    self.completeSignIn(id: user.uid)                                    //Auto login keychain
                }
                
                
            }
            
        })
        
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {       //Email and password method
        
        if let email = emailField.text, let pwd = passwordField.text{           //Check there is text in the feilds
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in  //Sign in with firebase
                if error == nil{                                                                    //User exists so we can sign in
                    
                    print("Hannan: User Authenticated by Email!")
                    if let user = user{                                             //Keychain autologin
                        self.completeSignIn(id: user.uid)
                    }
                    
                }else{                                                                              //User doesn't exist
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil{
                            print("Hannan: Unable to create user PASSWORD MUST BE MORE THAN 6 CHARECTERS")
                            
                            //Incorrect view
                            
                            self.redView.isHidden = false
                            self.incorrectLbl1.isHidden = false
                            self.incorrectLbl2.isHidden = false
                            self.incorrectLbl3.isHidden = false
                            self.tryAgainBtn.isHidden = false
                            
                            
                        }else{
                            
                            print("Hannan: Created new user Email Firebase")
                            if let user = user{                                             //Keychain autologin
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                    
                }
            })
            
        }
        
    }
    
    func completeSignIn(id: String){                                    //KEYCHAIN AUTO LOGIN
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "goToFeed", sender: nil)           //If keychain exists, login and goto next Feed
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
}

