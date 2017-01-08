//
//  Post.swift
//  socialapp
//
//  Created by Hannan Saleemi on 07/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

import Foundation

class Post{
    
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    
    var caption: String{
        return _caption
    }
    
    var imageUrl: String{
        return _imageUrl
    }
    
    var likes: Int{
        return _likes
    }
    
    var postKey: String{
        return _postKey
    }
    
    init(caption: String, imageUrl: String, likes: Int) {
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>){        //Parse data we recive from firebase
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String{                          //get caption from JSON DATA
            self._caption = caption
        }
        
        if let imageUrl = postData["imageURL"] as? String{                       //get imageurl from JSON DATA
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int{                               //get likes from JSON DATA
            self._likes = likes
        }
        
    }
    
}
