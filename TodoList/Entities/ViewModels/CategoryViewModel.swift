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

	var image: UIImage? {
		return UIImage(named: imagePath)?.withRenderingMode(.alwaysTemplate)
	}

	var color: Color {
		return Color(rawValue: colorName)!
	}

	init() {}

	init(model: Category) {
		id = model.id
		imagePath = model.imagePath
		name = model.name
		colorName = model.colorName
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
