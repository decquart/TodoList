//
//  TaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

typealias TaskDetailsHandler = ((Category, Scope<TaskViewModel>, Completion?) -> Void)

final class TaskListPresenter: TaskListPresenterProtocol {
	private(set) weak var view: TaskListViewProtocol?
	private let interactor: TaskListInteractorInput

	private var category: Category!
	private var tasks: [Task] = [] {
		didSet {
			view?.refreshTasks()
		}
	}

	var onPresentDetails: TaskDetailsHandler?

	required init(view: TaskListViewProtocol, interactor: TaskListInteractorInput, category: Category) {
		self.view = view
		self.interactor = interactor
		self.category = category
	}

	func loadTasks() {
		interactor.fetchTasks()
	}

	func numberOfRows() -> Int {
		return tasks.count
	}

	func task(at indexPath: IndexPath) -> TaskViewModel {
		return TaskViewModel(model: tasks[indexPath.row])
	}

	func buttonCompletePressed(at index: Int) {
		interactor.setCompleted(tasks[index])
	}

	func buttonImportantPressed(at index: Int) {
		interactor.setAsImportant(tasks[index])
	}

	func didCompleteAll() {
		interactor.completeAllUnfinished(tasks)
	}

	func didSelect(at indexPath: IndexPath) {
		let vm = TaskViewModel(model: tasks[indexPath.row])
		onPresentDetails?(category, .edit(model: vm)) { [weak self] in
			self?.loadTasks()
		}
	}

	func addButtonPressed() {
		onPresentDetails?(category, .create) { [weak self] in
			self?.loadTasks()
		}
	}
}

//MARK: - TaskListInteractorOutput
extension TaskListPresenter: TaskListInteractorOutput {
	func didLoadTasks(_ tasks: [Task]) {
		self.tasks = tasks
	}
}
