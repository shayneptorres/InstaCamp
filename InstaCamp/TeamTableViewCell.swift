//
//  TeamTableViewCell.swift
//  InstaCamp
//
//  Created by Shayne Torres on 5/30/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class TeamTableViewCell: UITableViewCell {
    var team: Team?{
        didSet{
            updateUI()
        }
    }
    var numberFormatter = NSNumberFormatter()

    @IBOutlet weak var teamFlag: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamPointsLabel: UILabel!
    @IBOutlet weak var teamLeaderLabel: MaterialLabel!
    
    func updateUI(){
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        if let team = self.team {
            print(team.name)
            print(team.points)
            print(team.flagImg)
            teamNameLabel.text = team.name
            teamLeaderLabel.text = " \(team.leader) "
            teamPointsLabel.text = " \(numberFormatter.stringFromNumber(team.points)!)pts "
            teamFlag.image = UIImage(named: team.flagImg)
        }
        
    }
    
}
