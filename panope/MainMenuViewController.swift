//
//  MainMenuViewController.swift
//  panope
//
//  Created by Julia Syi on 12/21/16.
//  Copyright © 2016 ksyi. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController{
    
    @IBOutlet weak var joinCarBtn: UIButton!

    @IBAction func joinCarBtn_click(sender: AnyObject) {
        print("CLICKED BUTTON: Join a Caravan")
        
        /*// Create an alert with textbox
        let alertController = UIAlertController(title: "PlainTextStyle", message: "PlainTextStyle AlertView.", preferredStyle: UIAlertControllerStyle.Alert)
        // Textbox
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField) -> Void in
            textField.placeholder = "Enter Caravan Pary Code"
        }
        // Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        // OK button
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            print(alertController.textFields?.first?.text)
        }
        // Add OK and Cancel button to dialog message
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        */

    }
}