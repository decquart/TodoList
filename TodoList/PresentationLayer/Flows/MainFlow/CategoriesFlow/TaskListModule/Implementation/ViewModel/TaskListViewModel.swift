//
//  TaskListViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 23.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class TaskListViewModel {

	private let repository: AnyRepository<Task>
	private let category: Category

	let disposeBag = DisposeBag()
	var tasks = BehaviorRelay<[TaskViewModel]>(value: [])

	let onPresentDetails = PublishSubject<Scope<TaskViewModel>>()
	let onReload = PublishSubject<Void>()

	var onPresent: TaskDetailsHandler?

	init(repository: AnyRepository<Task>, category: Category) {
		self.repository = repository
		self.category = category

		onPresentDetails
			.subscribe(onNext: { [weak self] scope in
				self?.onPresent?(category, scope) {
					self?.loadTasks()
				}
			})
			.disposed(by: disposeBag)
	}

	func loadTasks() {
		let predicate = NSPredicate(format: "ANY owner.id == %@", category.id)

		repository.fetch(where: predicate) { [weak self] result in
			if case let .success(items) = result {
				self?.tasks.accept(items.map { TaskViewModel(model: $0) })
			}
		}
	}

	func completeAllUnfinished() {
		tasks
			.flatMap { tasks -> Observable<[Task]> in
				let unfinished = tasks.filter { !$0.isCompleted }

				let modified = unfinished.map { task  -> Task in
					var item = task
					item.isCompleted.toggle()
					return item.mapToModel
				}

				return Observable.just(modified)
			}
			.subscribe(onNext: { [weak self] in
				self?.repository.update($0) { success in
					if success {
						self?.loadTasks()
					}
				}
			})
			.disposed(by: disposeBag)
	}

	func setCompleted(_ task: TaskViewModel) {
		var taskModel = task.mapToModel
		taskModel.completed.toggle()
		update(taskModel)
	}

	func setAsImportant(_ task: TaskViewModel) {
		var taskModel = task.mapToModel
		taskModel.isImportant.toggle()
		update(taskModel)
	}

	private func update(_ task: Task) {

		repository.update(task) { [weak self] success in
			if success {
				self?.loadTasks()
			}
		}
	}
}
