//
//  UILabel+Builder.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/21/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

extension UILabel {
    func align(_ d: NSTextAlignment) -> Self {
        textAlignment = d
        return self
    }
    
    func multiline() -> Self {
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        return self
    }
    
    func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
}
