//
//  CreatePost.swift
//  Sokolov 0.1.1
//
//  Created by test on 5/4/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation

class CreateComment: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBAction func Add(sender: AnyObject) {
        if let nvc = self.navigationController {
            nvc.popViewControllerAnimated(true)
            
        }else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    deinit {
            removeKeyboardNotifications()
    }

    func removeKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillShowNotification, object: nil)
    }

    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
       // scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrameSize.height)
        
        bottomConstraint.constant += keyboardFrameSize.height
        
        
    
    }
    
    func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}