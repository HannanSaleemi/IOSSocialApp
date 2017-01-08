//
//  CircleView.swift
//  socialapp
//
//  Created by Hannan Saleemi on 04/01/2017.
//  Copyright © 2017 Hannan Saleemi. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor     //Grey shadowing
        layer.shadowOpacity = 0.8                               //Opacity of shadow
        layer.shadowRadius = 5.0                                //How far is shadow goes out
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)    //How far the shadow goes out of bounds
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
        
        
    }

}
