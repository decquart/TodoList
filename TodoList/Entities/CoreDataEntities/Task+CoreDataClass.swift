//
//  TaskMO+CoreDataClass.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TaskMO)
public class TaskMO: NSManagedObject {

}

// MARK: - Mappable
extension TaskMO: Mappable {
	var mapToModel: Task {
		return Task(uuid: id,
					description: description_p,
					completed: completed,
					date: date,
					isImportant: important)
	}

	func map(_ model: Task) {
		self.id = model.uuid
		self.description_p = model.description
		self.completed = model.completed
		self.date = model.date
		self.important = model.isImportant
	}
}
