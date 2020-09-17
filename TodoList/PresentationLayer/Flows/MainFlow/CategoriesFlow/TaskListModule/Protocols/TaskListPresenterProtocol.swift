//
//  TaskListPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol TaskListPresenterProtocol: class {
	var view: TaskListViewProtocol? { get }

	func loadTasks()
	func numberOfRows() -> Int
	func task(at indexPath: IndexPath) -> TaskViewModel
	func buttonCompletePressed(at index: Int)
	func buttonImportantPressed(at index: Int)
	func didCompleteAll()
	func didSelect(at indexPath: IndexPath)
	func addButtonPressed()
}
