//
//  MaterialTextField.swift
//  InstaCamp
//
//  Created by Shayne Torres on 5/25/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue:SHADOW_COLOR, alpha:0.1).CGColor
        layer.borderWidth = 1.0
    }
    
    // Placeholder modifiers
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    // Text modifiers
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
}
