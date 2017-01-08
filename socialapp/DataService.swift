//
//  DataService.swift
//  socialapp
//
//  Created by Hannan Saleemi on 04/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()            //Grabs root database URL, which firebase handles automatically

let STORGAE_BASE = FIRStorage.storage().reference()         //Grabs root of storage URL, which firebase handles automatically

class DataService{
    
    
    static let ds = DataService()   //Creates a singleton - eveyone has access - global (starts with static)
    
    //Database Refrences
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")     //Follow root of database and find child posts URL
    private var _REF_USERS = DB_BASE.child("users")     //Follow root of database and find child users URL
    
    var REF_BASE: FIRDatabaseReference{                 //access these pirvate variables from anywhere in program
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference{
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference{
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>){       //Adding users to our database once authenticated and logged in
        
        REF_USERS.child(uid).updateChildValues(userData)                                //Brand new user getting a UID - updates values in DB
        
    }
    
    
    //Storage Refrences
    
    private var _REF_POST_IMAGES = STORGAE_BASE.child("post-pics")                      //Which folder in base url contain post images
    
    var REF_POST_IMAGES: FIRStorageReference{                                           
        return _REF_POST_IMAGES
    }
}



