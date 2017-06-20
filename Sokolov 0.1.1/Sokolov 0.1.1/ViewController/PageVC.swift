//
//  Page.swift
//  Sokolov 0.1.1
//
//  Created by test on 3/5/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class PageVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    let SS = APIStubService()
    var json : JSON = []
    var id: String = ""
    var TableArray = [String]()
    var NameArray = [String]()
    let CheckIC = CheckInternetConnection()
    
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
 
    @IBOutlet weak var Collection: CollectionForPage!
    
 
    @IBOutlet weak var TopBar: UINavigationItem!

    
    @IBAction func Save(sender: UIButton) {
        CoreDataManager.instance.savePerson(id, name: name.text!, record_count: ParseJSON.instance.parseWithoutId(json, first: "recordsCount")!, subscriber_count: ParseJSON.instance.parseWithoutId(json, first: "subscribersCount")!)
        CoreDataManager.instance.saveContext()
    }
    
    
    
    
    
    @IBOutlet weak var MyCollection: UICollectionView!
    
    override func viewDidLoad() {
        
        
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        TableArray = ["Новости", "Подписчики", "Владелец"]
        NameArray = ["recordsCount","subscribersCount","ownersCount"]
        
        json = SS.getPage(id)
        name.text = ParseJSON.instance.parseWithoutId(json, first: "name")
        photo.image = UIImage(named: "images")
        if (photo != nil) {
            photo.image = UIImage(named: "images")
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
         self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = CCellForPage()
       
        
        if CheckIC.isConnectedToNetwork() == true {
            if indexPath.row != 0 {
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CCellForPage
            }
            else {
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("lenta", forIndexPath: indexPath) as! CCellForPage
            }
        
            cell.Title.text = TableArray[indexPath.row]
            cell.Count.text = ParseJSON.instance.parseWithoutId(json, first: NameArray[indexPath.row])

        }
        else {
            if indexPath.row != 0 {
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CCellForPage
            }
            else {
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("lenta", forIndexPath: indexPath) as! CCellForPage
            }
            
            let fetchRequest = NSFetchRequest(entityName: "Page")
            fetchRequest.predicate = NSPredicate(format: "idPage == %@",id)
            
            do {
                let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Page]
                
                cell.Title.text = TableArray[indexPath.row]
                
                switch indexPath.row {
                case 0:
                     //alert
                    
                    let alertController = UIAlertController (title: "No internet connection", message: "Make sure ...", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alertController.addAction(UIAlertAction (title: "Ok", style: .Default , handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    //alert
                    
                    
                    let person = fetchEntity.first!
                    cell.Count.text = String(person.record_count!)
                    
                case 1:
                    let person = fetchEntity.first!
                    cell.Count.text = String(person.valueForKey("subscriber_count")!)
                
                default:
                    cell.Count.text = ""
                }
                
                
            }   catch {
                    print(ErrorType)
                }
        }
        return cell
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination: RecordsVC = segue.destinationViewController as! RecordsVC
        
        destination.idPage = id
        
    }

    
}

    
    
