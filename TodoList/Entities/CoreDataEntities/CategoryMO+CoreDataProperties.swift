//
//  CategoryMO+CoreDataProperties.swift
//  
//
//  Created by Volodymyr Mykhailiuk on 11.06.2020.
//
//

import Foundation
import CoreData


extension CategoryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryMO> {
        return NSFetchRequest<CategoryMO>(entityName: "CategoryMO")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var imagePath: String
    @NSManaged public var colorName: String
    @NSManaged public var tasks: NSSet

}

// MARK: Generated accessors for subTasks
extension CategoryMO {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskMO)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskMO)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
