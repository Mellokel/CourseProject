//
//  SomeData+CoreDataProperties.swift
//  Sokolov 0.1.1
//
//  Created by test on 6/7/17.
//  Copyright © 2017 test. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SomeData {

    @NSManaged var access: NSNumber?
    @NSManaged var email: String?
    @NSManaged var password: String?

}
