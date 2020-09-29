//
//  CategoryListModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

final class CategoryListModule {
	func build(onShowCategoryDetails: ScopeCategoryHandler?, onPresent: TaskHandler?) -> UIViewController {
		let view = CategoryListViewController.instantiate(storyboard: .main)
		let coreDataStack = CoreDataStackHolder.shared.coreDataStack
		let categoryRepository = CDCategoryRepository(coreDataStack: coreDataStack)
		let taskRepository = CDTaskRepository(coreDataStack: coreDataStack)
		let viewModel = CategoryListViewModel(categoryRepository: categoryRepository, taskRepository: taskRepository)

		view.viewModel = viewModel
		viewModel.onShowCategoryDetails = onShowCategoryDetails
		viewModel.onPresent = onPresent

		return view
	}
}
