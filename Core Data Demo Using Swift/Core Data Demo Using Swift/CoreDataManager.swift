//
//  CoreDataManager.swift
//  Core Data Demo Using Swift
//
//  Created by Apple on 08/07/25.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var context: NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }()

    func saveEmployee(name: String, address: String, empID: String, mobile: String, grade: String) {
        let employee = Employee(context: context)
        employee.name = name
        employee.address = address
        employee.empID = empID
        employee.mobile = mobile
        employee.grade = grade

        do {
            try context.save()
            print("✅ Saved")
        } catch {
            print("❌ Save failed: \(error)")
        }
    }

    func fetchEmployees() -> [Employee] {
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("❌ Fetch failed: \(error)")
            return []
        }
    }
}
