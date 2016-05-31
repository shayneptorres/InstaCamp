//
//  ManageTeamsViewController.swift
//  InstaCamp
//
//  Created by Shayne Torres on 5/29/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ManageTeamsViewController: UIViewController {
    let ref = FIRDatabase.database().reference()
    @IBOutlet weak var manageTeamsTableView: UITableView!
    
    
    
   @IBAction func goBackToManageTeamView(segue:UIStoryboardSegue){}
    
    
}
