//
//  TaskDetailsInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class TaskDetailsInteractor {
	weak var output: TaskDetailsInteractorOutput?
	private let repository: AnyRepository<Task>

	init(repository: AnyRepository<Task>) {
		self.repository = repository
	}
}

//MARK: - TaskDetailsInteractorInput
extension TaskDetailsInteractor: TaskDetailsInteractorInput {
	func update(task: Task) {
		repository.update(task) { [weak self] success in
			if success {
				self?.output?.didTaskUpdate()
			}
		}
	}
	
	func create(task: Task) {
		repository.add(task) { [weak self] success in
			if success {
				self?.output?.didTaskCreate()
			}
		}
	}
}
