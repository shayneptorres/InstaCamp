//
//  EditTeamScoreViewController.swift
//  InstaCamp
//
//  Created by Shayne Torres on 6/1/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditTeamScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreDisplay: MaterialLabel!
    @IBOutlet weak var AddPointsButton: MaterialButton!
    @IBOutlet weak var removePointsButton: MaterialButton!
    @IBOutlet weak var currentScoreDisplay: MaterialLabel!
    @IBOutlet weak var editTeamLabel: MaterialLabel!
    
    
    var team = Team()
    let ref = FIRDatabase.database().reference()
    var amount = Int()
    var amountText = "0"
    var addingPoint = true
    var numberFormatter1 = NSNumberFormatter()
    var def = NSUserDefaults.standardUserDefaults()
    var updateId = String()
    var currentUser = String()
    var Timestamp: String {
        return "\(NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .ShortStyle, timeStyle: .ShortStyle))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = def.valueForKey("currentUser") as! String
        numberFormatter1.numberStyle = NSNumberFormatterStyle.DecimalStyle
        editTeamLabel.text = "Edit \(team.name)'s Score"
        currentScoreDisplay.text = "Score: \(numberFormatter1.stringFromNumber(team.points)!)"
    }
    
    func updateDisplay(){
        let updateDisplayAmount = Int(amountText)!
        scoreDisplay.text = "\(numberFormatter1.stringFromNumber(updateDisplayAmount)!)"
    }
    
    
    @IBAction func appendDigit(sender: MaterialButton) {
        if amountText == "0" {
            amountText = ""
        }
        amountText += sender.currentTitle!
        updateDisplay()
    }
    
    @IBAction func backSpace(sender: MaterialButton) {
        if amountText.characters.count == 1 {
            amountText = "0"
        } else {
            amountText = String(amountText.substringToIndex(amountText.endIndex.predecessor()))
        }
        updateDisplay()
    }
    
    @IBAction func addPoints(sender: MaterialButton) {
        amount = Int(amountText)!
        ref.child("teams").child("\(team.name)").updateChildValues(["points":"\(team.points + amount)"])
//        var groupKey = ref.child("updates").childByAutoId()
        
        ref.child("updates").childByAutoId().setValue(["timestamp":"\(self.Timestamp)","type":"added", "points":"\(amount)","team":"\(team.name)","user":"\(def.valueForKey("currentUser")!)"])
        performSegueWithIdentifier("cancel1", sender: self)
    }
    
    @IBAction func removePoints(sender: MaterialButton) {
        amount = Int(amountText)!
        ref.child("teams").child("\(team.name)").updateChildValues(["points":"\(team.points - amount)"])
        ref.child("updates").childByAutoId().setValue(["timestamp":"\(self.Timestamp)","type":"removed", "points":"\(amount)","team":"\(team.name)","user":"\(def.valueForKey("currentUser")!)"])
        performSegueWithIdentifier("cancel1", sender: self)
    }
    
    
    @IBAction func cancel(sender: MaterialButton) {
        performSegueWithIdentifier("cancel1", sender: self)
    }
    
    func setUpdateId()-> String{
        updateId = "\(def.valueForKey("currentUser")!)\(arc4random_uniform(999))"
        return updateId
    }

}
