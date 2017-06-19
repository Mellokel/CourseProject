//
//  StartVC.swift
//  Sokolov 0.1.1
//
//  Created by test on 6/6/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit

class StartVC: UIViewController{
  
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    @IBOutlet weak var e_mailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    let validation = Validation()
    var SS = APIStubService()
    var json: JSON = []
    
    @IBAction func enterTapped(sender: AnyObject) {
        
        let email = e_mailField.text
        let password = passwordField.text
        let isValid = validation.validationEmail(email!)
        
        if isValid
        {
            if (SS.authorization(email!, password: password!)){ // access complete
                
                self.shouldPerformSegueWithIdentifier("MyPages", sender: self)
                
                
                CoreDataManager.instance.saveSomeData("access", dataBool: true)
                CoreDataManager.instance.saveSomeData("email", data: email!)
                CoreDataManager.instance.saveSomeData("password", data: password!)
                CoreDataManager.instance.saveContext()
            
            } else { //
            
                let alertController = UIAlertController (title: "Check your entered data", message: "Make sure ...", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction (title: "Ok", style: .Default , handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)

            }
           
        } else {
            let alertController = UIAlertController (title: "Mail is not valid", message: "Make sure ...", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction (title: "Ok", style: .Default , handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        
        }
        
    }
    
    
    
    override func viewDidLoad() {
        
        let SSS = APIRealService()
        SSS.getAllPages()
        
        menu.target = 	self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        CoreDataManager.instance.saveSomeData("access", dataBool: false)
        CoreDataManager.instance.saveContext()
    }
    
    // for keyboard
    override func viewDidAppear(animated: Bool) {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        super.viewDidAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
        super.viewWillDisappear(animated)
    }
    
    var keyboardDismissTapGesture: UIGestureRecognizer?
    
    func keyboardWillShow(notification: NSNotification) {
        if keyboardDismissTapGesture == nil
        {
            keyboardDismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            keyboardDismissTapGesture?.cancelsTouchesInView = false
            self.view.addGestureRecognizer(keyboardDismissTapGesture!)
        }
    
    }
    
    func dismissKeyboard(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func keyboardWillHide(notification: NSNotification){
        if keyboardDismissTapGesture != nil {
            self.view.removeGestureRecognizer(keyboardDismissTapGesture!)
            keyboardDismissTapGesture = nil
        }
    
    }
    
    
    
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "MyPages"{
            let destination: MyPagesVC = segue.destinationViewController as! MyPagesVC
            destination.email = e_mailField.text!
            destination.password = passwordField.text!
            
            
        
        }
    }
    
*/
}