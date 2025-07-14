//
//  Employee+CoreDataProperties.swift
//  Core Data Demo Using Swift
//
//  Created by Apple on 08/07/25.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var mobile: String?
    @NSManaged public var address: String?
    @NSManaged public var empID: String?
    @NSManaged public var grade: String?

}

extension Employee : Identifiable {

}
