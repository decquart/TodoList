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
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let interactor = TaskListInteractor(repository: repository, categoryId: category.id)
		let presenter = TaskListPresenter(view: view, interactor: interactor, category: category)
		presenter.onPresentDetails = onPresent
		view.presenter = presenter
		interactor.output = presenter
		return view
	}
}
