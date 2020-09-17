//
//  TaskDetailsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//


class TaskDetailsPresenter: TaskDetailsPresenterProtocol {
	private(set) weak var view: TaskDetailsViewProtocol?

	private var subTask: Task?
	private let interactor: TaskDetailsInteractorInput

	var onDismiss: Completion?
	var onAddTask: Completion?

	init(view: TaskDetailsViewProtocol, interactor: TaskDetailsInteractorInput) {
		self.view = view
		self.interactor = interactor
	}

	func sendButtonPressed(viewModel: TaskViewModel) {
		view?.isNewTask == true
			? interactor.create(task: viewModel.mapToModel)
			: interactor.update(task: viewModel.mapToModel)
	}
}

//MARK: - TaskDetailsInteractorOutput
extension TaskDetailsPresenter: TaskDetailsInteractorOutput {
	func didTaskCreate() {
		self.onAddTask?()
		self.view?.invalidateView()
	}

	func didTaskUpdate() {
		self.onAddTask?()
		self.onDismiss?()
	}
}
