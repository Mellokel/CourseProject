//
//  MyPagesVC.swift
//  Sokolov 0.1.1
//
//  Created by test on 6/5/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MyPagesVC : UITableViewController {
   
    let checkIC = CheckInternetConnection()
    
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var SS = APIStubService()
    var json: JSON = []
    
    var email = ""
    var password = ""
    
    
    override func viewDidAppear(animated: Bool) {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    
    override func viewDidLoad() {
        
        
        
        menu.target = 	self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        if(email == ""){
            let fetchRequest = NSFetchRequest(entityName: "SomeData")
            do {
                let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [SomeData]
                
                let someData = fetchEntity.first!
                email = someData.email!
                password = someData.password!
                
            }   catch {
                print(ErrorType)
            }            
        }
            if checkIC.isConnectedToNetwork() {
                
                json = SS.getMyPages(email, password: password)
            }
            else {
                let alertController = UIAlertController (title: "No internet connection", message: "Make sure ...", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction (title: "Ok", style: .Default , handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        
        
        
     }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if checkIC.isConnectedToNetwork() {
                return json.count
            }
            else {
                return 0
             }
     }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        if checkIC.isConnectedToNetwork() {
            
                cell.Name.text = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "name")
                
                cell.photo.image = UIImage(named: "images")
                
                cell.id = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "id")!
            
        }
        else { // no internet connection
            
        }
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let destination: PageVC = segue.destinationViewController as! PageVC
        let index = tableView.indexPathForSelectedRow
        
        let cell = tableView.cellForRowAtIndexPath(index!) as! CustomCell
        destination.id = cell.id
        
    }

}
