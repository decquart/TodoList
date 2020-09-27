//
//  TaskListModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class TaskListModule {
	func build(category: Category, onPresent: TaskDetailsHandler?) -> UIViewController {
		let view = TaskListViewController.instantiate(storyboard: .task)
		let repository = CDTaskRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		repository.setCategoryId(category.id)
		let viewModel = TaskListViewModel(repository: repository, category: category)

		view.viewModel = viewModel
		viewModel.onPresent = onPresent

		return view
	}
}
