//
//  RankedTeamTableViewCell.swift
//  InstaCamp
//
//  Created by Shayne Torres on 6/1/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class RankedTeamTableViewCell: UITableViewCell {
    var team: Team?{
        didSet{
            updateUI()
        }
    }
    var numberFormatter1 = NSNumberFormatter()
    var numberFormatter2 = NSNumberFormatter()
    
    @IBOutlet weak var rankLabel: MaterialLabel!
    @IBOutlet weak var nameLabel: MaterialLabel!
    @IBOutlet weak var pointsLabel: MaterialLabel!
    @IBOutlet weak var flagImage: UIImageView!
    
    func updateUI(){
        numberFormatter1.numberStyle = NSNumberFormatterStyle.DecimalStyle
        numberFormatter2.numberStyle = NSNumberFormatterStyle.OrdinalStyle
        if let team = self.team {
            print(team.name)
            print(team.points)
            print(team.flagImg)
            nameLabel.text = " \(team.name) "
            rankLabel.layer.cornerRadius = 5
            rankLabel.text = " \(numberFormatter2.stringFromNumber(team.rank)!) "
            pointsLabel.text = " \(numberFormatter1.stringFromNumber(team.points)!)pts "
            flagImage.image = UIImage(named: team.flagImg)
        }
    }
}
