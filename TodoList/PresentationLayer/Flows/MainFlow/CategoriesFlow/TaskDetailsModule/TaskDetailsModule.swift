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
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let interactor = TaskDetailsInteractor(repository: repository)
		let presenter = TaskDetailsPresenter(view: view, interactor: interactor)

		view.presenter = presenter
		view.scope = scope
		interactor.output = presenter
		presenter.onDismiss = onDismiss
		presenter.onAddTask = onAddTask

		return view
	}
}
