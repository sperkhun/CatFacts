//
//  Users+CoreDataProperties.swift
//  
//
//  Created by Serhii PERKHUN on 1/8/19.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}
