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
    // Variables
    let ref = FIRDatabase.database().reference()
    var teams = [Team]()
    var teamsDict = [String:AnyObject]()
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
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
            
            self.teams = self.teams.sort(){$0.name < $1.name}
            self.tableView.reloadData()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "editScore":
                let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
                if let etsvc = segue.destinationViewController as?
                    EditTeamScoreViewController {
                    etsvc.team = self.teams[indexPath.row]
                }
            default:
                break
            }
        }
    }
    
    // Table View Functions
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
    
    // Unwind Seque
    @IBAction func goBackToTeamsViewController(segue:UIStoryboardSegue){}
    
    

}
