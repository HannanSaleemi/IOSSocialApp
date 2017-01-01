//
//  FancyField.swift
//  socialapp
//
//  Created by Hannan Saleemi on 01/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

/////COCOA TOUCH CLASS/////
//Editing UITextField//

import UIKit

class FancyField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.2).cgColor    //Set border on textfield
        layer.borderWidth = 1.0                                 //Set border thickness
        layer.cornerRadius = 2.0                                //Set corner rounded
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {            //Set text inset (so it does touch the start of border)
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}
