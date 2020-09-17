//
//  Task.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

struct Task {
	let uuid: String
	var description: String
	var completed: Bool
	var date: Date
	var isImportant: Bool

	init(uuid: String = UUID().uuidString, description: String, completed: Bool, date: Date, isImportant: Bool) {
		self.uuid = uuid
		self.description = description
		self.completed = completed
		self.date = date
		self.isImportant = isImportant
	}
}
