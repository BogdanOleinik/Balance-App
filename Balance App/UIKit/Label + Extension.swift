//
//  Label + Extension.swift
//  Balance App
//
//  Created by Олейник Богдан on 19.05.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir16()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir16(), textColor: UIColor?) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
