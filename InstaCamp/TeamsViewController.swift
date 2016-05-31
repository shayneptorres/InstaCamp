//
//  TeamsViewController.swift
//  InstaCamp
//
//  Created by Shayne Torres on 5/29/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TeamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ref = FIRDatabase.database().reference()
    var teams = [Team]()
    var things = ["one","two","three"]
    var teamsDict = [String:AnyObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref.child("teams").observeEventType(.Value, withBlock: {snapshot in
            self.teamsDict = snapshot.value as! [String : AnyObject]
            print(self.teamsDict)
            
            for (k,v) in self.teamsDict {
                let t = Team(n: k, d:v as! [String : String])
                self.teams.append(t)
            }
            self.tableView.reloadData()
        })
    ref.child("teams").child("Mexico").setValue(["points":"750","leader":"Pedro"])

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        for i in self.teams {
            print("FOR REALZ: teams: \(i.name), points: \(i.points), leader: \(i.leader)")
        }
    }
    
    
    @IBAction func printTeams(sender: UIButton) {
        for i in self.teams {
            print("FOR REALZ: teams: \(i.name), points: \(i.points), leader: \(i.leader)")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TeamTableViewCell
        cell.team = self.teams[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    

}
