//
//  MaterialLabel.swift
//  InstaCamp
//
//  Created by Shayne Torres on 6/1/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class MaterialLabel: UILabel {
    
    override func awakeFromNib() {
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }

}
