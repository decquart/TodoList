//
//  TaskListInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class TaskListInteractor {
	weak var output: TaskListInteractorOutput?
	private let repository: AnyRepository<Task>
	private let categoryId: String

	init(repository: AnyRepository<Task>, categoryId: String) {
		self.repository = repository
		self.categoryId = categoryId
	}
}

//MARK: - TaskListInteractorInput
extension TaskListInteractor: TaskListInteractorInput {
	func fetchTasks() {
		let predicate = NSPredicate(format: "ANY owner.id == %@", categoryId)

		repository.fetch(where: predicate) { [weak self] result in
			if case let .success(items) = result {
				self?.output?.didLoadTasks(items)
			}
		}
	}

	func completeAllUnfinished(_ tasks: [Task]) {
		let unfinished = tasks.filter { !$0.completed }
		if unfinished.isEmpty { return }

		let modified = unfinished.map { task -> Task in
			var item = task
			item.completed.toggle()
			return item
		}

		repository.update(modified) { [weak self] _ in
			self?.fetchTasks()
		}
	}

	func setCompleted(_ task: Task) {
		var task = task
		task.completed.toggle()
		update(task)
	}

	func setAsImportant(_ task: Task) {
		var task = task
		task.isImportant.toggle()
		update(task)
	}

	private func update(_ task: Task) {
		repository.update(task) { [weak self] success in
			if success {
				self?.fetchTasks()
			}
		}
	}
}
