//
//  CategoryListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

typealias ScopeCategoryHandler = (Scope<CategoryViewModel>) -> Void
typealias TaskHandler = (Category) -> Void

final class CategoryListPresenter: CategoryListPresenterProtocol {

	weak var view: CategoryListViewProtocol?
	let interactor: CategoryListInteractorInput

	var categoriesCount: Int {
		return interactor.categoriesCount
	}

	var onShowCategoryDetails: ScopeCategoryHandler?
	var onPresentTasks: TaskHandler?

	required init(view: CategoryListViewProtocol, interactor: CategoryListInteractorInput) {
		self.view = view
		self.interactor = interactor
	}

	func category(at index: Int) -> CategoryViewModel {
		let category = interactor.category(by: index)
		return CategoryViewModel(model: category)
	}

	func tasksCount(at index: Int) -> Int {
		return interactor.taskCount(by: index)
	}

	func loadCategories() {
		interactor.fetchCategories()
	}

	func didSelectCategory(with index: Int) {
		let category = interactor.category(by: index)
		onPresentTasks?(category)
	}

	func deleteButtonPressed(with index: Int) {
		interactor.delete(by: index)
	}

	func editButtonPressed(with index: Int) {
		let category = interactor.category(by: index)
		let vm = CategoryViewModel(model: category)

		onShowCategoryDetails?(.edit(model: vm))
	}

	func addCategoryButtonPressed() {
		onShowCategoryDetails?(.create)
	}
}

extension CategoryListPresenter: CategoryListInteractorOutput {
	func didUpdateCategories() {
		view?.reload()
	}
}
