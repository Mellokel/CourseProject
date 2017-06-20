//
//  BackTableVC.swift
//  Sokolov 0.1.1
//
//  Created by test on 3/4/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class BackTableVC: UITableViewController {
    
    var TableArray = [[String]()]
    var RTableArray = [[String]()]
    var accessComplite = false
    var breakPoint = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableArray = [["My pages","Other pages"]]
        RTableArray = [["Мои страницы","Другие страницы"]]
      
     
    }
    override func viewDidAppear(animated: Bool) {

        
  /*
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BackTableVC.accessIsAllowed), name: "AccessIsAllowed", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BackTableVC.accessIsDenied), name: "AccessIsDenied", object: nil)
    */
 
        
        let fetchRequest = NSFetchRequest(entityName: "SomeData")
        do {
            let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [SomeData]
            
            let someData = fetchEntity.first!
                accessComplite = someData.access!.boolValue
            
        }   catch {
            print(ErrorType)
        }
        
            if accessComplite {
                accessIsAllowed()
            } else {
                accessIsDenied()
            }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.reuseIdentifier == "Exit" {
            CoreDataManager.instance.saveSomeData("access", dataBool: false)
            CoreDataManager.instance.saveSomeData("email", data: "")
            CoreDataManager.instance.saveSomeData("password", data: "")
            CoreDataManager.instance.saveContext()
            
        }
        
    }
    
    
    func accessIsAllowed() {
        TableArray = [["My pages","Other pages"],["Exit"]]
        RTableArray = [["Мои страницы","Другие страницы"],["Выход"]]
        tableView.reloadData()
        
    }
    
    func accessIsDenied() {
        TableArray = [["Other pages","Authorization"]]
        RTableArray = [["Другие страницы","Авторизация"]]
       tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableArray.count
    }
 
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.section][indexPath.row], forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = RTableArray[indexPath.section][indexPath.row]
        
        
        return cell
    }
    
    
    
}