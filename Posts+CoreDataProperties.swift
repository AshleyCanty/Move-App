//
//  Posts+CoreDataProperties.swift
//  TheMoveApp
//
//  Created by ashley canty on 8/13/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//
//

import Foundation
import CoreData


extension Posts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts")
    }

    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var imgName: String?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}
