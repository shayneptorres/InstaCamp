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

    @IBOutlet weak var teamNameLabel: UILabel!
    
    func updateUI(){
        print("this should happen")
        if let team = self.team {
            print("This is Happening")
            print(team.name)
            print(team.points)
            print(team.leader)
            teamNameLabel.text = team.name
        }
        
    }
    
}
