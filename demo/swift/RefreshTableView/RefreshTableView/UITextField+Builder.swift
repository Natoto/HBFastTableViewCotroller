//
//  UITextField+Builder.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/21/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

extension UITextField {
    func withPlaceholder(_ placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    func secure() -> Self {
        isSecureTextEntry = true
        return self
    }
    
    func returnKey(_ type: UIReturnKeyType) -> Self {
        returnKeyType = type
        return self
    }
    
    func keyboard(_ type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }
    
    func autocap(_ type: UITextAutocapitalizationType) -> Self {
        autocapitalizationType = type
        return self
    }
    
    func autocorrect(_ type: UITextAutocorrectionType) -> Self {
        autocorrectionType = type
        return self
    }
    
    func delegateTo(_ object: UITextFieldDelegate) -> Self {
        delegate = object
        return self
    }
    
    func fontSize(_ size: CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: size)
        return self
    }
    
    func withFont(_ name: String, ofSize size: CGFloat) -> Self {
        font = UIFont(name: name, size: size)
        return self
    }
}
