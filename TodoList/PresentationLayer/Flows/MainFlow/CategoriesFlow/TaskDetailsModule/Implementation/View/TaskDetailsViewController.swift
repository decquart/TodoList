//
//  TaskDetailsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

final class TaskDetailsViewController: UIViewController {
	var viewModel: TaskDetailsViewModel!
	let disposeBag = DisposeBag()

	@IBOutlet weak private var textField: UITextField! {
		didSet {
			textField.layer.cornerRadius = textField.frame.height / 2
		}
	}

	@IBOutlet weak private var sendButton: UIButton! {
		didSet {
			sendButton.tintColor = ThemeService.shared.applicationColor.uiColor
		}
	}
	@IBOutlet weak private var datePicker: UIDatePicker!

	override func viewDidLoad() {
        super.viewDidLoad()

		setupBindings()
		viewModel.initAppearance()
    }

	func setupBindings() {
		sendButton.rx.tap
			.bind { [weak self] in self?.viewModel.sendButtonPressed() }
			.disposed(by: disposeBag)

		textField.rx.text.orEmpty
			.bind(to: viewModel.taskSubject)
			.disposed(by: disposeBag)

		viewModel.taskSubject
			.bind(to: textField.rx.text)
			.disposed(by: disposeBag)

		datePicker.rx.date
			.bind(to: viewModel.dateSubject)
			.disposed(by: disposeBag)

		viewModel.dateSubject
			.bind(to: datePicker.rx.date)
			.disposed(by: disposeBag)

		viewModel.onPersistTask
			.subscribe(onNext: { [weak self] in
				self?.textField.text = ""
				self?.datePicker.date = Date()
			})
			.disposed(by: disposeBag)

		viewModel.isValidSendButton
			.bind(to: sendButton.rx.isEnabled)
			.disposed(by: disposeBag)
	}
}
