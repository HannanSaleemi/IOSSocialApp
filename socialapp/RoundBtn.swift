//
//  RoundBtn.swift
//  socialapp
//
//  Created by Hannan Saleemi on 01/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

/////COCOA TOUCH CLASS//////
//Turns the default button with FB logo to a Round Button


import UIKit

class RoundBtn: UIButton {

    override func awakeFromNib() {      //Simple shadowing of button
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor     //Grey shadowing
        layer.shadowOpacity = 0.8                               //Opacity of shadow
        layer.shadowRadius = 5.0                                //How far is shadow goes out
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)    //How far the shadow goes out of bounds
        
        imageView?.contentMode = .scaleAspectFit                //Makes button ASPECT FIT
        
    }
    
    override func layoutSubviews() {
        //Creating the perfect circle button
        super.layoutSubviews()
        
        layer.cornerRadius = (self.frame.width / 4)       //Set corner radius (frame size / 2 to get even round button)
        
    }
    
}
