//
//  AddTeamViewController.swift
//  InstaCamp
//
//  Created by Shayne Torres on 5/29/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddTeamViewController: UIViewController {

    let ref = FIRDatabase.database().reference()
    @IBOutlet weak var teamName: MaterialTextField!
    @IBOutlet weak var teamPoints: MaterialTextField!
    
    
    @IBAction func addTeam(sender: MaterialButton) {
        let tn = teamName.text!
        let p = teamPoints.text!
        ref.child("teams").child("\(tn)").setValue(["points":"\(p)"])
        print("added team")
        performSegueWithIdentifier("cancel", sender: self)
    }
    
    
    
    @IBAction func cancel(sender: MaterialButton) {
        performSegueWithIdentifier("cancel", sender: self)
    }
    
}
