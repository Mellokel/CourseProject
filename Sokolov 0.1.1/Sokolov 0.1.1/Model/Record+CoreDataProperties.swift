//
//  Record+CoreDataProperties.swift
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

extension Record {

    @NSManaged var comment_count: NSNumber?
    @NSManaged var content: String?
    @NSManaged var date: String?
    @NSManaged var head: String?
    @NSManaged var id: String?
    @NSManaged var like_count: NSNumber?
    @NSManaged var photo_count: NSNumber?
    @NSManaged var repost_count: NSNumber?
    @NSManaged var whoseRecords: Page?

}
