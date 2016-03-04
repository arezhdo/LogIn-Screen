//
//  LogInViewController.swift
//  App
//
//  Created by Arlinda Rezhdo on 11/8/15.
//  Copyright © 2015 muses. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {
    
    // Create Outlets for texfields
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    //
    // MARK: - Actions
    //
    @IBAction func loginAction(sender: AnyObject) {
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        // Validate the text fields: 
        // If username is less than 5 characters display alert that shows the problem
        if username?.characters.count < 5 {
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } 
        // If password is less than 8 characters display alert that shows the problem
        else if password?.characters.count < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } 
        // Otherwise continue with the login
        else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login to Parse
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                // If there was a username found in Parse, then show success 
                if ((user) != nil) {
                    let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    // Instantiate View Controller with storyboard ID
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tabbed")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } 
                // Otherwise, show message of error
                else {
                    let alert = UIAlertView(title: "Error", message: "Your username or password do not match!", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Navigation
    //
    // Connect buttons with exit view in .storyboard file
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }
    

}
