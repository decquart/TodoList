//
//  Category.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

struct Category: Decodable {
	let id: String
	let name: String
	let imagePath: String
	let colorName: String
	let tasksCount: Int

	init(id: String = UUID().uuidString, name: String, imagePath: String, colorName: String, subtasksCount: Int = 0) {
		self.id = id
		self.name = name
		self.imagePath = imagePath
		self.colorName = colorName
		self.tasksCount = subtasksCount
	}
}
