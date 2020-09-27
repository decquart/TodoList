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
	var tasks = BehaviorSubject<[TaskViewModel]>(value: [])

	let onDelete = PublishRelay<IndexPath>()
	let onPresentDetails = PublishSubject<Scope<TaskViewModel>>()
	let onReload = PublishSubject<Void>()

	var onPresent: TaskDetailsHandler?

	var categoryName: String {
		return category.name
	}

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

		onDelete
			.map { $0.row }
			.withLatestFrom(tasks) { row, tasks in
				return tasks[row]
			}
			.map { $0.mapToModel }
			.flatMap { [unowned self] in
				return self.delete($0)
			}
			.subscribe(onNext: { [weak self] success in
				if success {
					self?.loadTasks()
				}
			})
			.disposed(by: disposeBag)
	}

	func loadTasks() {
		let predicate = NSPredicate(format: "ANY owner.id == %@", category.id)

		repository.fetch(where: predicate) { [weak self] result in
			if case let .success(items) = result {
				self?.tasks.onNext(items.map { TaskViewModel(model: $0) })
			}
		}
	}

	func completeAllUnfinished() {
		guard let tasks = try? tasks.value() else {
			return
		}

		let modified = tasks
			.filter { !$0.isCompleted }
			.map { unfinished -> Task in
				var modified = unfinished
				modified.isCompleted.toggle()
				return modified.mapToModel
			}

		self.repository.update(modified) { [weak self] success in
			if success {
				self?.loadTasks()
			}
		}
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

	private func delete(_ task: Task) -> Observable<Bool> {
		return Observable.create { [weak self] observer in
			let disposable = Disposables.create()

			self?.repository.delete(task) { success in
				observer.onNext(success)
			}

			return disposable
		}
	}

	private func update(_ task: Task) {

		repository.update(task) { [weak self] success in
			if success {
				self?.loadTasks()
			}
		}
	}
}
