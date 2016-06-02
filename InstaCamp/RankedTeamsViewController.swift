//
//  RankedTeamsViewController.swift
//  InstaCamp
//
//  Created by Shayne Torres on 6/1/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RankedTeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let ref = FIRDatabase.database().reference()
    var teams = [Team]()
    var teamsDict = [String:AnyObject]()
    var rank = 1
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Call to databse
        
        ref.child("teams").observeEventType(.Value, withBlock: {snapshot in
            self.teamsDict = snapshot.value as! [String : AnyObject]
            self.teams = []
            for (k,v) in self.teamsDict {
                let t = Team(n: k, d:v as! [String : String])
                self.teams.append(t)
            }
            
            self.teams = self.teams.sort(){Int($0.points) > Int($1.points)}
        
            for i in self.teams {
                i.rank = self.rank
                self.rank += 1
            }
            self.rank = 1
            self.tableView.reloadData()
        })
    }
    
    // Table View Functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellRanked", forIndexPath: indexPath) as! RankedTeamTableViewCell
        cell.team = self.teams[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    

}
