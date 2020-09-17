//
//  TaskListUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol TaskListInteractorInput: class {
	var output: TaskListInteractorOutput? { get }
	func fetchTasks()
	func completeAllUnfinished(_ tasks: [Task])
	func setCompleted(_ task: Task)
	func setAsImportant(_ task: Task)
}

protocol TaskListInteractorOutput: class {
	func didLoadTasks(_ tasks: [Task])
}
