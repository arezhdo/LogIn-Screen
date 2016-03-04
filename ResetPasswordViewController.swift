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
    
    //
    // Create Outlet for textfield
    //
    @IBOutlet weak var emailField: UITextField!
    
    //
    // Create Action for Reset Password Button
    //
    @IBAction func resetPassword(sender: AnyObject) {
        let email = self.emailField.text
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Send a request to reset a password
        PFUser.requestPasswordResetForEmailInBackground(finalEmail)
        
        let alert = UIAlertController (title: "Password Reset", message: "An email containing information on how to reset your password has been sent to " + finalEmail + ".", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // Should not outorotate
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
