//
//  ExtendedHelper.swift
//  DynEdTestAssesment
//
//  Created by Fajar on 8/28/18.
//  Copyright © 2018 Fajar. All rights reserved.
//

import UIKit
import SDWebImage

extension UIColor {
    convenience init(r:Int,g:Int,b:Int,a:CGFloat = 1) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
    }
}

extension UIImageView {
    func setImageURL(url:String, placeholder:UIImage? = nil){
        var ph = self.image
        if let _ = placeholder {
            ph = placeholder
        }
        guard let urls = URL(string: url) else{return}
        self.sd_setImage(with: urls, placeholderImage: ph, options:.delayPlaceholder) { (image, error, type, url) in
            if let e = error {
                print("error \(e)")
            }
            
        }
    }
}

extension UIView {
    @IBInspectable
    var cornerRadius:CGFloat {
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get{
            return layer.cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth:CGFloat {
        set{
            layer.borderWidth = newValue
        }
        get{
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor:UIColor {
        set{
            layer.borderColor = newValue.cgColor
        }
        get{
            return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor)
        }
    }
}


