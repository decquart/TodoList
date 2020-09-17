//
//  TaskObject.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 09.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RealmSwift
import Foundation

final class TaskObject: Object {

	@objc dynamic var id = ""
	@objc dynamic var description_p = ""
	@objc dynamic var isCompleted = false
	@objc dynamic var date = Date()
	@objc dynamic var isImportant = false
	let owner = LinkingObjects(fromType: CategoryObject.self, property: "tasks")

	override class func primaryKey() -> String? {
		return "id"
	}
}

// MARK: - Mappable
extension TaskObject: Mappable {
	var mapToModel: Task {
		Task(uuid: id, description: description_p, completed: isCompleted, date: date, isImportant: isImportant)
	}

	func map(_ entity: Task) {
		if id.isEmpty {
			id = entity.uuid
		}
		description_p = entity.description
		isCompleted = entity.completed
		date = entity.date
		isImportant = entity.isImportant
	}
}
