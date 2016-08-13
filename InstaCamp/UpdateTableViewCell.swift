//
//  UpdateTableViewCell.swift
//  InstaCamp
//
//  Created by Shayne Torres on 6/6/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class UpdateTableViewCell: UITableViewCell {
    var update: Update?{
        didSet{
            updateUI()
        }
    }
    
    var type = String()
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var teamLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    func updateUI(){
        if update!.type == "added" {
            pointsLabel.textColor = UIColor.init(netHex: 0x27E27E)
            pointsLabel.text = "+\(update!.points)pts"
        } else {
             pointsLabel.textColor = UIColor.redColor()
             pointsLabel.text = "-\(update!.points)pts"
        }
        usernameLabel.text = update?.user
        teamLabel.text = update?.team
        timestampLabel.text = update?.time
    }

}
