//
//  ScoreEditsViewController.swift
//  InstaCamp
//
//  Created by Shayne Torres on 6/5/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ScoreEditsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let ref = FIRDatabase.database().reference()
    var updatesUnordered = [Update]()
    var updates = [Update]()
    var updatesDict = [String:AnyObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        ref.child("updates").observeEventType(.Value, withBlock: {snapshot in
            print(snapshot.value!)
            if String(snapshot.value!) == "<null>" {
            } else {
                self.updatesDict = snapshot.value as! [String : AnyObject]
            }
            self.updates = []
            for (k,v) in self.updatesDict {
                print("this")
                let u = Update(id: k, d:v as! [String : String])
                self.updates.append(u)
            }
            self.updates = self.updates.sort(){($0.updateID) > ($1.updateID)}
            self.tableView.reloadData()
        })
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("update", forIndexPath: indexPath) as! UpdateTableViewCell
        cell.update = self.updates[indexPath.row]
        return cell
    }
}
