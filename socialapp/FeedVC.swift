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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: CircleView!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!                   //Pick image from camera roll
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()       //Cache setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()                 //Initialize image picker
        imagePicker.allowsEditing = true                        //Allows cropping of the picture
        imagePicker.delegate = self                             //set delegate to self image picker
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Listerners - listens for changes eg) likes/posts removed etc
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in          //Refrence to database - posts section
            
            //print(snapshot.value!)                          //This prints JSON data of posts in the database and updates in realtime automatically
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{       //Get eveyrthing under posts
                
                for snap in snapshot{
                    //print("SNAP: \(snap)")                      //PRINT objects with the post data inside eg) likes, imageURL, caption
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject>{     //Parse data
                        let key = snap.key                                              //Get ket is possible
                        let post = Post(postKey: key, postData: postDict)               //Get post key and value pairs
                        self.posts.append(post)                                         //Append to post array
                    }
                    
                }
                
            }
            self.tableView.reloadData()                          //Once we have the posts reload table view with all posts
            
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {       //Sections mostly one
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {       //How many cells
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let post = posts[indexPath.row]                 //get post
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell{       //Create the cell
            
            //Download images
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString){
                cell.configureCell(post: post, img: img)
                return cell
            }else{
                cell.configureCell(post: post)              //update ui for post cell
                return cell
            }
            
        }else{
            return PostCell()
        }
    }

    
    @IBAction func signOutTapped(_ sender: UITapGestureRecognizer) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)      //Remove key from KEYCHAIN from autologin
        try! FIRAuth.auth()?.signOut()                              //Sign out of Firebase
        performSegue(withIdentifier: "goToSignIn", sender: nil)     //Back to Login Screen
        
    }
    
    
    //Set image and Once chosen image, get rid of image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            imageAdd.image = image
        }else{
            print("Hannan: a valid image wasn't selected!")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageTapped(_ sender: Any) {                      //Add image button tapped (Tap gesture recogniser)
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
}































