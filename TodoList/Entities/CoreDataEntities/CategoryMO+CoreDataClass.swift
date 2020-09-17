//
//  CategoryMO+CoreDataClass.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 04.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CategoryMO)
public class CategoryMO: NSManagedObject {

}

// MARK: - Mappable
extension CategoryMO: Mappable {
	var mapToModel: Category {
		return Category(id: id,
					name: name,
					imagePath: imagePath,
					colorName: colorName,
					subtasksCount: tasks.count)
	}

	func map(_ entity: Category) {
		id = entity.id
		name = entity.name
		imagePath = entity.imagePath
		colorName = entity.colorName
	}
}
