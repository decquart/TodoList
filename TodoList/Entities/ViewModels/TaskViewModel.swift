//
//  TaskViewModel.swift
//  TodoList
//
//  Created by volodymyr on 22.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

struct TaskViewModel {
	private var id: String = UUID().uuidString
	private var isCompleted: Bool = false
	var description: String = ""
	var date: Date = Date()
	var isImportant: Bool = false

	var checkmarkIcon: UIImage {
		isCompleted
			? UIImage(systemName: "checkmark.circle.fill")!
			: UIImage(systemName: "circle")!
	}

	var importantIcon: UIImage {
		return isImportant
			? UIImage(systemName: "star.fill")!
			: UIImage(systemName: "star")!
	}

	var importantIconColor: UIColor {
		return ThemeService.shared.applicationColor.uiColor
	}

	var dateText: String {
		if Calendar.current.isDateInToday(date) {
			return "Today"
		}

		if Calendar.current.isDateInTomorrow(date) {
			return "Tomorrow"
		}

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM'/'dd"
		return dateFormatter.string(from: date)
	}

	init() {}

	init(model: Task) {
		id = model.uuid
		isCompleted = model.completed
		description = model.description
		date = model.date
		isImportant = model.isImportant
	}
}

// MARK: - MappingOutput
extension TaskViewModel: MappingOutput {
	var mapToModel: Task {
		Task(uuid: id, description: description, completed: isCompleted, date: date, isImportant: isImportant)
	}
}
