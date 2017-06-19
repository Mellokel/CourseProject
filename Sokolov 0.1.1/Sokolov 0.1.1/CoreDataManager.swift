//
//  CoreDataManager.swift
//  Sokolov 0.1.1
//
//  Created by test on 4/23/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager :AppDelegate{

    static let instance = CoreDataManager()
    
    func checkElement (id: String, entity: String) -> Bool{
        
        
        let fetchRequest = NSFetchRequest(entityName: entity)
        
        do {
            
            switch entity {
                case "Page":
                    fetchRequest.predicate = NSPredicate(format: "idPage == %@",id)
                    let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Page]
             
                    if  fetchEntity.isEmpty {
                        return true
                    }
                case "Record":
                    fetchRequest.predicate = NSPredicate(format: "id == %@",id)
                    let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Record]
            
             
                    if  fetchEntity.isEmpty {
                        return true
                    }
                case "SomeData":
                    let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [SomeData]
                
                    if fetchEntity.isEmpty {
                        return true
                    }
                
                default:
                    print("CoreDataManager/ checkElement/ switch")
            }
            
            
        } catch {
            print(error)
        }
        return false
    }
    
    
    func saveSomeData (name: String, data: String) {
        if checkElement("", entity: "SomeData"){
            let entity = CoreDataManager.instance.entityForName("SomeData")
            let someData = NSManagedObject(entity: entity, insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
            
            someData.setValue(data, forKey: name)

        } else {
        let fetchRequest = NSFetchRequest(entityName: "SomeData")
            do {
                let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [SomeData]
                fetchEntity.first!.setValue(data, forKey: name)
                
            }
            catch {}

        }
    }
    
    func saveSomeData (name: String, dataBool: Bool) {
        if checkElement("", entity: "SomeData"){
            let entity = CoreDataManager.instance.entityForName("SomeData")
            let someData = NSManagedObject(entity: entity, insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
            
            someData.setValue(dataBool, forKey: name)
            
        } else {
            let fetchRequest = NSFetchRequest(entityName: "SomeData")
            do {
                let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [SomeData]
                fetchEntity.first!.setValue(dataBool, forKey: name)
            }
            catch {}
        }
     }
    
    func savePerson (id: String, name: String, record_count: String, subscriber_count: String)  {
        
        
        if checkElement(id, entity: "Page") { //new element
            
            let entity = CoreDataManager.instance.entityForName("Page")
            let person = NSManagedObject(entity: entity, insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
            
            person.setValue(id, forKey: "idPage")
            person.setValue(name, forKey: "name")
            
            
            person.setValue(Int(record_count), forKey: "record_count")
            person.setValue(Int(subscriber_count), forKey: "subscriber_count")
            
            
        }
        else { // already created
            let fetchRequest = NSFetchRequest(entityName: "Page")
            fetchRequest.predicate = NSPredicate(format: "idPage == %@",id)
            
            do {
                let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Page]
                
                fetchEntity.first!.setValue(name, forKey: "name")
                
                
                fetchEntity.first!.setValue(Int(record_count), forKey: "record_count")
                fetchEntity.first!.setValue(Int(subscriber_count), forKey: "subscriber_count")
                
            }
            catch {}
            
        }
    }
    
    func savePost(idPage: String,idPost: String , head: String, content: String, date: String, autor: String ) {
        if checkElement(idPage, entity: "Page") == false  {
            if checkElement(idPost, entity: "Record"){
                let entityRec = CoreDataManager.instance.entityForName("Record")
                let record = NSManagedObject(entity: entityRec, insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
                record.setValue(head, forKey: "head")
                record.setValue(content,forKey: "content")
                record.setValue(date, forKey: "date")
               // record.setValue(autor, forKey: "autor")
                record.setValue(idPost, forKey: "id")
                
                
                let fetchRequest = NSFetchRequest(entityName: "Page")
                fetchRequest.predicate = NSPredicate(format: "idPage == %@",idPage)
                
                do {
                    let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Page]
                    
                    let page = fetchEntity.first!
                    
                    record.setValue(page, forKey: "whoseRecords")
                    
                    
                }
                catch {print("fetch entity/ CoreDataManager/ savePost/ first conditional")}
            }else {
                
                let fetchRequest = NSFetchRequest(entityName: "Record")
                fetchRequest.predicate = NSPredicate(format: "id == %@",idPost)
                
                do {
                    let fetchEntity = try CoreDataManager.instance.managedObjectContext.executeFetchRequest(fetchRequest) as! [Record]
                    
                    let record = fetchEntity.first!
                    
                    record.setValue(head, forKey: "head")
                    record.setValue(content,forKey: "content")
                    record.setValue(date, forKey: "date")
                  //  record.setValue(autor, forKey: "autor")
                    record.setValue(idPost, forKey: "id")
                    
                }
                catch {print("fetch entity/ CoreDataManager/ savePost/ first conditional")}

            
            }
        }
        else {print("Can't save/ CoreDataManager/ savePost/ first conditional")}
    }

    
    
    
    func entityForName (entityName: String) -> NSEntityDescription {
    
    return NSEntityDescription.entityForName(entityName, inManagedObjectContext: self.managedObjectContext )!
    
    }
    
    func fetchedResultsController (entityName: String,keyForSort: String) -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        let sortDescrtiptor = NSSortDescriptor(key: keyForSort, ascending:  true)
        fetchRequest.sortDescriptors = [sortDescrtiptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:  CoreDataManager.instance.managedObjectContext, sectionNameKeyPath:  nil, cacheName: nil)
        return fetchedResultController
    }
    
    func fetchedResultsController (entityName: String) -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: entityName)
       
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:  CoreDataManager.instance.managedObjectContext, sectionNameKeyPath:  nil, cacheName: nil)
        return fetchedResultController
    }


   


}
