//
//  Page+CoreDataProperties.swift
//  Sokolov 0.1.1
//
//  Created by test on 5/5/17.
//  Copyright © 2017 test. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Page {

    @NSManaged var name: String?
    @NSManaged var record_count: NSNumber?
    @NSManaged var subscriber_count: NSNumber?
    @NSManaged var idPage: String?
    @NSManaged var records: NSSet?

}
