//
//  TaskDetailsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class TaskDetailsModule {
	func build(with category: Category, and scope: Scope<TaskViewModel>, onDismiss: Completion?, onAddTask: Completion?) -> UIViewController {
		let view = TaskDetailsViewController.instantiate(storyboard: .taskDetails)
		let repository = CDTaskRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		repository.setCategoryId(category.id)
		let viewModel = TaskDetailsViewModel(repository: repository, scope: scope)

		view.viewModel = viewModel
		viewModel.onDismiss = onDismiss
		viewModel.onAddTask = onAddTask

		return view
	}
}
