//
//  CategoiesCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 03.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class CategoiesCoordinator: BaseCoordinator {
	override func start() {
		showCategoryListModule()
	}

	func handle(_ link: DeepLink) {
		switch link {
		case .createCategory:
			showCategoryDetails(scope: .create)
		}
	}
}

// MARK: - Flows
private extension CategoiesCoordinator {
	func showCategoryListModule() {
		let module = CategoryListModule().build(onShowCategoryDetails: showCategoryDetails(scope:),
												onPresent: showTasks(category:))

		router.setRootModule(module, animated: false)
	}

	func showCategoryDetails(scope: Scope<CategoryViewModel>) {
		let module = CategoryDetailsModule().build(scope: scope,
												   onDismiss: router.pop)

		self.router.push(module)
	}

	func showTasks(category: Category) {
		let module = TaskListModule().build(category: category,
											onPresent: showTaskDetails)

		self.router.push(module)
	}

	func showTaskDetails(category: Category, scope: Scope<TaskViewModel>, onAddTask: Completion?) {
		let module = TaskDetailsModule().build(with: category,
											   and: scope,
											   onDismiss: router.dismiss,
											   onAddTask: onAddTask)

		self.router.presentInteractiveScreen(module)
	}
}
