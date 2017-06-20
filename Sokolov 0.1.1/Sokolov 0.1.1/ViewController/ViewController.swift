//
//  ViewController.swift
//  Sokolov 0.1.1
//
//  Created by test on 3/4/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var Open: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Open.target = 	self.revealViewController()
        Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

