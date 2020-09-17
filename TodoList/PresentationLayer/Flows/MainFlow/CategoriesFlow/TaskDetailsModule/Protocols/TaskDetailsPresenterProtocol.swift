//
//  TaskDetailsPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol TaskDetailsPresenterProtocol: class {
	var view: TaskDetailsViewProtocol? { get }

	func sendButtonPressed(viewModel: TaskViewModel)
}
