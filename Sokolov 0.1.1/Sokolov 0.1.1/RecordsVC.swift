//
//  LentaVC.swift
//  Sokolov 0.1.1
//
//  Created by test on 4/2/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import CoreData

class RecordsVC: UITableViewController {

    var idPage = ""
    var json: JSON = []
    var SS = APIStubService()
    let CheckIC = CheckInternetConnection()
    var dataWasLoad = false
    var fetchedData = [Record]()
    
    override func viewDidLoad() {
        dataWasLoad = false
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        json = SS.getPosts(idPage)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        
        if CheckIC.isConnectedToNetwork() == false {
            if !dataWasLoad {
                fetchData()
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if CheckIC.isConnectedToNetwork() == true {
            return 5
        } else {
            return fetchedData.count
        }
    }
    override func viewDidAppear(animated: Bool) {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = CCellForRecords()
        
        
        if CheckIC.isConnectedToNetwork() == true {
            let Cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CCellForRecords
       
            Cell.name.text = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "Autor")
            Cell.date.text = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "Date")
            Cell.content.text = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "Content")
        
            let head = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "Head")
        
            let idPost = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "idPost")
        
            if !CoreDataManager.instance.checkElement(idPage, entity: "Page") {
            
                CoreDataManager.instance.savePost(idPage, idPost: idPost!, head: head!, content: Cell.content.text!, date: Cell.date.text!, autor: Cell.name.text!)
        
                CoreDataManager.instance.saveContext()
            }
            cell = Cell
        
        } else { // no internet connection
            let Cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CCellForRecords
            
            
            
            let record = fetchedData[indexPath.row]
            
            Cell.content.text = record.content
            Cell.date.text = record.date
            
            // bigCell.name.text = String(record.valueForKey("autor"))
            
            cell = Cell

           
        }
        return cell
    }

    func fetchData(){
    
        let fetchRequest = NSFetchRequest(entityName: "Record")
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        do {
            let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Record]
            
            fetchedData = fetchEntity
            dataWasLoad = true
            
        }   catch {
            print(ErrorType)
        }
    
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination: RecordVC = segue.destinationViewController as! RecordVC
        
        let indexPath = tableView.indexPathForSelectedRow?.row
        
        destination.idPost = ParseJSON.instance.parseWithId(json, id: indexPath!, first: "idPost")!
        destination.idPage = idPage
    }
    
}