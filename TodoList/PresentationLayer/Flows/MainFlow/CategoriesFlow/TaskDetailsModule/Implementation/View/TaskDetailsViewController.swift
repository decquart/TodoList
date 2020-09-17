//
//  TaskDetailsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class TaskDetailsViewController: UIViewController {
	var presenter: TaskDetailsPresenterProtocol!
	var scope: Scope<TaskViewModel> = .create

	private var viewModel: TaskViewModel {
		if case let .edit(task) = scope  {
			return task
		}

		return TaskViewModel()
	}

	@IBOutlet weak private var textField: UITextField!
	@IBOutlet weak private var sendButton: UIButton! {
		didSet {
			sendButton.tintColor = ThemeService.shared.applicationColor.uiColor
		}
	}
	@IBOutlet weak private var datePicker: UIDatePicker!

	override func viewDidLoad() {
        super.viewDidLoad()

		initAppearance()
    }

	@IBAction private func sendButtonPressed(_ sender: Any) {
		guard let text = textField.text, !text.isEmpty else {
			return
		}

		var task = viewModel
		task.description = text
		task.date = datePicker.date
		presenter.sendButtonPressed(viewModel: task)
	}

	func initAppearance() {
		switch scope {
		case .edit(let task):
			textField.text = task.description
			datePicker.date = task.date
		default:
			break
		}
	}
}

extension TaskDetailsViewController: TaskDetailsViewProtocol {

	var isNewTask: Bool {
		if case .create = scope {
			return true
		}

		return false
	}

	func invalidateView() {
		textField.text = ""
		datePicker.date = Date()
	}
}
