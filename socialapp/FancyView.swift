//
//  FancyView.swift
//  socialapp
//
//  Created by Hannan Saleemi on 01/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

////////MUST BE A COCOA TOUCH CLASS/////////
////////MUST BE SUBCLASS OF OBJECT EDITING (when creating) EG) IF WERE EDITING UIView, subclass: UIView - UIButton, subclass: UIButton

////This is for editing the shadow on the UIView, to apply this, make sure the Class on the UIView is set to FancyView
////Any view you want to have this shadow settings for, change the class for the UIView to FancyView
////Adds a small subtle shadow (noticiable at the bottom in Login Screen), giving a nice 3D Effect

import UIKit

class FancyView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor     //Grey shadowing
        layer.shadowOpacity = 0.8                               //Opacity of shadow
        layer.shadowRadius = 5.0                                //How far is shadow goes out
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)    //How far the shadow goes out of boundss
        
    }

}
