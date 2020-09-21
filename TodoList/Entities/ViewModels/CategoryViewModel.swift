//
//  TaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 20.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct CategoryViewModel {
	private var id: String = UUID().uuidString
	var name: String = ""
	var imagePath: String = ""
	var colorName: String = ""
	var taskCount: Int = 0

	var image: UIImage? {
		return UIImage(named: imagePath)?.withRenderingMode(.alwaysTemplate)
	}

	var color: Color {
		return Color(rawValue: colorName)!
	}

	init() {}

	init(model: Category, taskCount: Int = 0) {
		self.id = model.id
		self.imagePath = model.imagePath
		self.name = model.name
		self.colorName = model.colorName
		self.taskCount = taskCount
	}
}

// MARK: - MappingOutput
extension CategoryViewModel: MappingOutput {
	var mapToModel: Category {
		return Category(id: id,
					name: name,
					imagePath: imagePath,
					colorName: colorName)
	}
}
