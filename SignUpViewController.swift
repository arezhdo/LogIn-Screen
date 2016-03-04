//
//  SignUpViewController.swift
//  App
//
//  Created by Arlinda Rezhdo on 11/8/15.
//  Copyright © 2015 muses. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController {
    
    // Assign Outlets to textfields
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //
    // MARK: - Actions 
    //
    // When the user taps the Sign Up button the following method is triggered
    @IBAction func signUpAction(sender: AnyObject) {
        
        // Assign variables to the entries in the textfields
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Validate the text fields
        // If username has less than 5 characters show invalid message
        if username?.characters.count < 5 {
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } 
        // If password doesn't have at least 8 characters show invalid message
        else if password?.characters.count < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } 
        // If email doesn't have 8 characters show invalid message
        // ?? FIX for verifying if e-mail exists ??
        else if email?.characters.count < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Please enter a valid email address", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } 
        // Otherwise create entry in Parse list
        else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                // If there was an error at signup show error
                if ((error) != nil) {
                    let alert = UIAlertView(title: "Error", message: "There was a problem with your sign up. Please try again later.", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } 
                // Otherwise show success and navigate to next view controller with storyboard ID
                else {
                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tabbed")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    }
    
    //
    // MARK: - Functions
    //
    // Screen should not outorotate for this particular View Controller
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    // The only supported interface orientation is portrait!
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
