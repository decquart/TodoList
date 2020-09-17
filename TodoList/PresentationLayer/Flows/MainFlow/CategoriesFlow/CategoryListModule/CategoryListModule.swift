//
//  CategoryListModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class CategoryListModule {
	func build(onShowCategoryDetails: ScopeCategoryHandler?, onPresent: TaskHandler?) -> UIViewController {
		let view = CategoryListViewController.instantiate(storyboard: .main)
		let coreDataStack = CoreDataStackHolder.shared.coreDataStack
		let repository = CDCategoryRepository(coreDataStack: coreDataStack)
		let interactor = CategoryListInteractor(repository: repository)
		let presenter = CategoryListPresenter(view: view, interactor: interactor)
		presenter.onShowCategoryDetails = onShowCategoryDetails
		presenter.onPresentTasks = onPresent
		interactor.output = presenter
		view.presenter = presenter
		return view
	}
}
