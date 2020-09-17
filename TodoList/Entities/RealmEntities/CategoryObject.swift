//
//  CategoryObject.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RealmSwift
import Foundation
import UIKit

class CategoryObject: Object {

	@objc dynamic var id = ""
	@objc dynamic var name = ""
	@objc dynamic var imagePath = ""
	@objc dynamic var colorName = ""

	let tasks = List<TaskObject>()

	override class func primaryKey() -> String? {
		return "id"
	}
}

// MARK: - Mappable
extension CategoryObject: Mappable {
	var mapToModel: Category {
		Category(id: id,
			 name: name,
			 imagePath: imagePath,
			 colorName: colorName,
			 subtasksCount: tasks.count)
	}

	func map(_ entity: Category) {
		if id.isEmpty {
			id = entity.id
		}

		name = entity.name
		imagePath = entity.imagePath
		colorName = entity.colorName
	}
}
