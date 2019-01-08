//
//  Users+CoreDataClass.swift
//  
//
//  Created by Serhii PERKHUN on 1/8/19.
//
//

import Foundation
import CoreData

@objc(Users)
public class Users: NSManagedObject {

    convenience init() {
        let context = UserManager.instance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        
        self.init(entity: entity!, insertInto: context)
    }
    
}
