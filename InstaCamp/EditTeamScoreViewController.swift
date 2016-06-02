//
//  EditTeamScoreViewController.swift
//  InstaCamp
//
//  Created by Shayne Torres on 6/1/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit

class EditTeamScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreDisplay: MaterialLabel!
    @IBOutlet weak var AddPointsButton: MaterialButton!
    @IBOutlet weak var removePointsButton: MaterialButton!
    
    var amount = 0
    var amountText = ""
    var addingPoint = true
    
    func updateDisplay(){
        scoreDisplay.text = amountText
    }

    @IBAction func toggleAddPoints(sender: MaterialButton) {
        addingPoint = true
    }
    
    @IBAction func toggleRemovePoints(sender: MaterialButton) {
        addingPoint = false
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
    
    
    @IBAction func cancel(sender: MaterialButton) {
        performSegueWithIdentifier("cancel1", sender: self)
    }
    
    
    @IBAction func submitScore(sender: MaterialButton) {
        performSegueWithIdentifier("cancel1", sender: self)
    }

}
