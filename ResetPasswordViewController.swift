//
//  ResetPasswordViewController.swift
//  App
//
//  Created by Arlinda Rezhdo on 11/8/15.
//  Copyright © 2015 muses. All rights reserved.
//

import UIKit
import Parse

class ResetPasswordViewController: UIViewController {
    
    // Create Outlet for textfield
    @IBOutlet weak var emailField: UITextField!
    
    //
    // MARK: - Actions
    //
    @IBAction func resetPassword(sender: AnyObject) {
        let email = self.emailField.text
        // Create variable to convert a faulty e-mail input
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Send a request to reset a password through PARSE
        PFUser.requestPasswordResetForEmailInBackground(finalEmail)
        
        // Show the user that an e-mail verification was sent
        let alert = UIAlertController (title: "Password Reset", message: "An email containing information on how to reset your password has been sent to \(finalEmail).", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //
    // MARK: - Functions
    //
    // Screen should not outorotate
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

}
