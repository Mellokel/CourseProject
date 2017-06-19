//
//  IPagesVC.swift
//  Sokolov 0.1.1
//
//  Created by test on 3/27/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class PagesVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    let searchBar = UISearchBar()
    let checkIC = CheckInternetConnection()
    var fetchResult = NSFetchedResultsController()
    var filteredDictionary = [String:String]()
    var filteredArrayId = [String]()
    var shouldShowSearchResults = false
    //var cellCount = 0
    
    
    var identiti = 0
    
    @IBOutlet var Table: UITableView!
    
    var SS = APIStubService()
    var json: JSON = []
    
    func createSearchBar()  {
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Поиск страницы"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDictionary = [:]
        filteredArrayId = []
        var dictionary = [String:String]()
        
        
        if checkIC.isConnectedToNetwork() {
            json = SS.getAllPages()
            dictionary = ParseJSON.instance.parseGetDictionary(json, first: "Name")!
            
            for (id , name) in dictionary{
                if name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil {
                    filteredDictionary[id] = name
                }
            }
            filteredArrayId = [String](filteredDictionary.keys)
        } else { // no internet connection
            let fetchRequest = NSFetchRequest(entityName: "Page")
            
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            do {
                let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Page]
                
                for page in fetchEntity {
                    if page.name?.lowercaseString.rangeOfString(searchText.lowercaseString) != nil{
                        filteredArrayId.append(page.idPage!)
                    }
                    
                }
                
            } catch { print("PagesVC/ searchbar/ catch") }
        
        }
        
        
        
        if searchText != "" {
            shouldShowSearchResults = true
            tableView.reloadData()
        } else {
            json = SS.getPages(8)
            shouldShowSearchResults = false
            tableView.reloadData()
        }
        
        
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    
    func respond(gesture: UIGestureRecognizer) {
        
    //    cellCount += 8
        
        
    }
    
    override func viewDidLoad() {
        menu.target = 	self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
       /* let swipeDown = UISwipeGestureRecognizer(target: self, action:#selector(respond))
        swipeDown.direction = .Down
        tableView.addGestureRecognizer(swipeDown)
        */
        
        
        createSearchBar()
        if checkIC.isConnectedToNetwork() {
            json = SS.getPages(8)
        }
        else {
            fetchResult = CoreDataManager.instance.fetchedResultsController("Page", keyForSort: "idPage")
            
            do {
                try fetchResult.performFetch()
            }
            catch
            {
                print(error)
            }
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldShowSearchResults {
            return filteredArrayId.count
        } else {
            if checkIC.isConnectedToNetwork() {
                return 8
            }
            else {
                if let sections = fetchResult.sections{
                    return sections[section].numberOfObjects
                } else {
                    return 0
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
            let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
            if checkIC.isConnectedToNetwork() {
                if shouldShowSearchResults {
                    let jsonForCell = SS.getPage(filteredArrayId[indexPath.row], name: filteredDictionary[filteredArrayId[indexPath.row]]!)
                    
                    cell.Name.text = ParseJSON.instance.parseWithoutId(jsonForCell, first: "name")
                    cell.photo.image = UIImage(named: "images")
                    cell.id = ParseJSON.instance.parseWithoutId(jsonForCell, first: "id")!
                    
                    
                
                } else {
                    cell.Name.text = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "name")
                    
                    cell.photo.image = UIImage(named: "images")
                    
                    cell.id = ParseJSON.instance.parseWithId(json, id: indexPath.row, first: "id")!
                }
            
            }
            else { // no internet connection
            
                if shouldShowSearchResults {
                    let fetchRequest = NSFetchRequest(entityName: "Page")
                    fetchRequest.predicate = NSPredicate(format: "idPage == %@",filteredArrayId[indexPath.row])
                    
                    do {
                        let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Page]
                    
                        let person = fetchEntity.first!
                        cell.Name.text = person.name
                        cell.id = person.idPage!
                    } catch { print ("IpagesVC/ UITableViewCell/  Problem with Core Data") }
                    
                } else {
                
                    let person = fetchResult.objectAtIndexPath(indexPath) as! Page
            
                    cell.Name.text = person.name
                    cell.id = person.idPage!
                }
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


