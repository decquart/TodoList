//
//  TaskDetailsViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 24.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RxSwift

final class TaskDetailsViewModel {

	private let scope: Scope<TaskViewModel>
	private let repository: AnyRepository<Task>

	let disposeBag = DisposeBag()

	let taskSubject = BehaviorSubject<String>(value: "")
	let dateSubject = BehaviorSubject<Date>(value: Date())

	let onPersistTask = PublishSubject<Void>()
	let onDismiss = PublishSubject<Void>()

	let isValidSendButton = BehaviorSubject<Bool>(value: false)

	init(repository: AnyRepository<Task>, scope: Scope<TaskViewModel>) {
		self.repository = repository
		self.scope = scope

		taskSubject
			.subscribe(onNext: { [weak self] in
				self?.isValidSendButton.onNext(!$0.isEmpty)
			})
			.disposed(by: disposeBag)
	}

	func initAppearance() {
		switch scope {
		case .edit(let task):
			taskSubject.onNext(task.description)
			dateSubject.onNext(task.date)
		default:
			break
		}
	}

	func sendButtonPressed() {
		Observable.zip(taskSubject, dateSubject)
			.flatMap { [weak self] desc, date -> Observable<Task> in
				var viewModel = self?.scope.model ?? TaskViewModel()
				viewModel.description = desc
				viewModel.date = date

				return Observable.just(viewModel.mapToModel)
			}
			.subscribe(onNext: { [weak self] in
				guard let self = self else {  return }

				switch self.scope {
				case .create:
					self.create(task: $0)
				case .edit:
					self.update(task: $0)
				}
			})
			.disposed(by: disposeBag)

	}

	private func update(task: Task) {
		repository.update(task) { [weak self] success in
			if success {
				self?.onPersistTask.onNext(())
				self?.onDismiss.onNext(())
			}
		}
	}

	private func create(task: Task) {
		repository.add(task) { [weak self] success in
			if success {
				self?.onPersistTask.onNext(())
			}
		}
	}
}
