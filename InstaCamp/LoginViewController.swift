//
//  LoginViewController.swift
//  InstaCamp
//
//  Created by Shayne Torres on 5/26/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextFeild: MaterialTextField!
    @IBOutlet weak var passwordTextField: MaterialTextField!
    @IBOutlet weak var staffPasswordTextFeild: MaterialTextField!
    @IBOutlet weak var signIn_UpButton: MaterialButton!
    @IBOutlet weak var errorView: Material_View!
    @IBOutlet weak var errorTypeLabel: UILabel!
    @IBOutlet weak var errorDirectionLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var userQuestionLabel: UILabel!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var def = NSUserDefaults.standardUserDefaults()
    var willSignUp = true
    var errorViewsIsDown = false
    var word = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRDatabase.database().persistenceEnabled = true
        self.emailTextFeild.delegate = self
        self.passwordTextField.delegate = self
        self.staffPasswordTextFeild.delegate = self
        activitySpinner.hidden = true
        let transform = CGAffineTransformMakeScale(2.0, 2.0)
        activitySpinner.transform = transform;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
            let ref = FIRDatabase.database().reference()
            ref.child("secrets").child("word").observeEventType(.Value, withBlock: {snapshot in
            self.word = snapshot.value as! String
            print(self.word)
        })
        
    }
    
    
    @IBAction func signUpUser(sender: MaterialButton) {
        self.startActivitySpinner()
        if willSignUp {
            if staffPasswordTextFeild.text! == word {
                FIRAuth.auth()?.createUserWithEmail(emailTextFeild.text!, password: passwordTextField.text!, completion: {
                    user, error in
                    
                    if error != nil {
                        self.errorTypeLabel.text = "Password Error"
                        self.errorDirectionLabel.text = "\(error!.localizedDescription)"
                        _ = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(LoginViewController.showErrorMessage), userInfo: nil, repeats: false)
                        print(String(error!.localizedDescription))
                    } else {
                        self.def.setValue("\(self.emailTextFeild.text!)", forKey: "currentUser")
                        self.segueToTeamsPage()
                        print("New user has been logged in")
                    }
                    self.stopActivitySpinner()
                })
            } else {
                errorTypeLabel.text = "Incorrect Staff Password"
                errorDirectionLabel.text = "You must enter the correct Staff password to sign up."
                _ = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(LoginViewController.showErrorMessage), userInfo: nil, repeats: false)
                self.stopActivitySpinner()
            }
        } else {
            FIRAuth.auth()?.signInWithEmail(emailTextFeild.text!, password: passwordTextField.text!, completion: {
                user, error in
                
                if error != nil {
                    if (error?.code)! == 17020 {
                        self.errorTypeLabel.text = "Connection Failure"
                        self.errorDirectionLabel.text = "Cannot connect to the database, retry with a better connection"
                    } else {
                        self.errorTypeLabel.text = "Incorrect email/password"
                        self.errorDirectionLabel.text = "Your email and/or password is incorrect"

                    }
                    _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(LoginViewController.showErrorMessage), userInfo: nil, repeats: false)
                } else {
                    self.def.setValue("\(self.emailTextFeild.text!)", forKey: "currentUser")
                    self.segueToTeamsPage()
                    print("user has been logged in")
                }
                self.stopActivitySpinner()
            })
        }
    }
    
    func segueToTeamsPage(){
        performSegueWithIdentifier("login", sender: self)
    }
    
    @IBAction func setLogInMode(sender: MaterialButton) {
        if willSignUp == true {
            willSignUp = false
            setDisplay()
        } else {
            willSignUp = true
            setDisplay()
        }
    }
    
    
    @IBAction func toggleLogInSignUp(sender: UIButton) {
        if willSignUp == true {
            willSignUp = false
            setDisplay()
        } else {
            willSignUp = true
            setDisplay()
        }
    }
    
    @IBAction func setSignUpMode(sender: MaterialButton) {
        if willSignUp == true {
        } else {
            willSignUp = true
            print(willSignUp)
            setDisplay()
        }
    }
    
    func setDisplay(){
        if willSignUp == true {
            userQuestionLabel.text = "Already signed up?"
            toggleButton.setTitle("Login", forState: UIControlState.Normal)
            signIn_UpButton.setTitle("Sign Up", forState: UIControlState.Normal)
            slideStaffPasswordRight()
        } else {
            userQuestionLabel.text = "Not signed up yet?"
            toggleButton.setTitle("Sign Up", forState: UIControlState.Normal)
            signIn_UpButton.setTitle("Login", forState: UIControlState.Normal)
            slideStaffPasswordLeft()
        }
    }
    
    // Animations
    func slideStaffPasswordLeft(){
        UIView.animateWithDuration(0.2, animations: {self.staffPasswordTextFeild.center.x -= self.view.bounds.width }, completion: {finished in})
    }
    
    func slideStaffPasswordRight(){
        staffPasswordTextFeild.hidden = false
        UIView.animateWithDuration(0.2, animations: {self.staffPasswordTextFeild.center.x += self.view.bounds.width }, completion: {finished in})
    }
    
    func showErrorMessage(){
        disableButton()
        slideErrorViewsUp()
        _ = NSTimer.scheduledTimerWithTimeInterval(3.4, target: self, selector: #selector(LoginViewController.enableButton), userInfo: nil, repeats: false)
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(LoginViewController.unhideErrorViews), userInfo: nil, repeats: false)
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(LoginViewController.slideErrorViewsDown), userInfo: nil, repeats: false)
        _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(LoginViewController.slideErrorViewsUp), userInfo: nil, repeats: false)
        _ = NSTimer.scheduledTimerWithTimeInterval(3.3, target: self, selector: #selector(LoginViewController.hideErrorViews), userInfo: nil, repeats: false)
        _ = NSTimer.scheduledTimerWithTimeInterval(3.3, target: self, selector: #selector(LoginViewController.slideErrorViewsDown), userInfo: nil, repeats: false)
    }
    
    func slideErrorViewsUp(){
        UIView.animateWithDuration(0.1, animations: {self.errorView.center.y -= self.view.bounds.width}, completion: {finished in})
        UIView.animateWithDuration(0.1, animations: {self.errorTypeLabel.center.y -= self.view.bounds.width}, completion: {finished in})
        UIView.animateWithDuration(0.1, animations: {self.errorDirectionLabel.center.y -= self.view.bounds.width}, completion: {finished in})
    }
    
    func slideErrorViewsDown(){
        UIView.animateWithDuration(0.1, animations: {self.errorView.center.y += self.view.bounds.width}, completion: {finished in})
        UIView.animateWithDuration(0.1, animations: {self.errorTypeLabel.center.y += self.view.bounds.width}, completion: {finished in})
        UIView.animateWithDuration(0.1, animations: {self.errorDirectionLabel.center.y += self.view.bounds.width}, completion: {finished in})
    
    }
    
    func hideErrorViews(){
        self.errorView.hidden = true
        self.errorTypeLabel.hidden = true
        self.errorDirectionLabel.hidden = true
    }
    
    func unhideErrorViews(){
        self.errorView.hidden = false
        self.errorTypeLabel.hidden = false
        self.errorDirectionLabel.hidden = false
    }
    
    func disableButton(){
        signIn_UpButton.enabled = false
    }
    
    func enableButton(){
        signIn_UpButton.enabled = true
    }
    
    func startActivitySpinner(){
        activitySpinner.hidden = false
        activitySpinner.startAnimating()
    }
    
    func stopActivitySpinner(){
        activitySpinner.stopAnimating()
        activitySpinner.hidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


