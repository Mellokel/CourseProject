//
//  Record.swift
//  Sokolov 0.1.1
//
//  Created by test on 4/23/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import CoreData


class Record: NSManagedObject {

    class func getRecordsOfPage(idPage: String) -> NSFetchedResultsController {
    
        let fetchRequest = NSFetchRequest(entityName: "Record")
        
      //  let sortDescriptor = NSSortDescriptor(key: "whoseRecords.id", ascending: true)
       // fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "%K == %@", "whoseRecords.id", idPage )
        fetchRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil )
        
        return fetchedResultsController
    }
}
