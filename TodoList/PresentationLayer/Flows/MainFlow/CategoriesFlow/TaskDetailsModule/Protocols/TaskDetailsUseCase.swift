//
//  TaskDetailsUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol TaskDetailsInteractorInput: class {
	var output: TaskDetailsInteractorOutput? { get }

	func update(task: Task)
	func create(task: Task)
}

protocol TaskDetailsInteractorOutput: class {
	func didTaskCreate()
	func didTaskUpdate()
}
