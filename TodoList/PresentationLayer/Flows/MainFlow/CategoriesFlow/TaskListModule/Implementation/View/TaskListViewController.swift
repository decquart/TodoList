//
//  TaskListViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class TaskListViewController: UIViewController, UITableViewDelegate {
	var viewModel: TaskListViewModel!
	let disposseBag = DisposeBag()

	lazy var completeAllBarItem = {
		return UIBarButtonItem(title: "Complete All", style: .plain, target: nil, action: nil)
	}()

	@IBOutlet weak var addButton: AddButton!
	@IBOutlet weak private var tableView: UITableView! {
		didSet {
			tableView.rx
				.setDelegate(self)
				.disposed(by: disposseBag)
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = completeAllBarItem

		setupBindings()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationItem.title = viewModel.categoryName

		viewModel.loadTasks()
	}

	func setupBindings() {
		completeAllBarItem.rx.tap
			.subscribe(onNext: { [weak self] in
				self?.viewModel.completeAllUnfinished()
			})
			.disposed(by: disposseBag)

		viewModel.tasks.bind(to: tableView.rx.items(cellIdentifier: "TaskCell", cellType: TaskCell.self)) { [weak self] row, task, cell in
			cell.configure(with: task)

			cell.checkButton.rx.tap
				.bind { self?.viewModel.setCompleted(task) }
				.disposed(by: cell.disposeBag)

			cell.importantButton.rx.tap
				.bind { self?.viewModel.setAsImportant(task) }
				.disposed(by: cell.disposeBag)
		}
		.disposed(by: disposseBag)

		Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(TaskViewModel.self))
			.subscribe(onNext: { [weak self] in
				self?.tableView.deselectRow(at: $0, animated: true)
				self?.viewModel.onPresentDetails.onNext(.edit(model: $1))
			})
			.disposed(by: disposseBag)

		addButton.rx.tap
			.bind { [weak self] in self?.viewModel.onPresentDetails.onNext(.create) }
			.disposed(by: disposseBag)

		viewModel.onReload
			.subscribe(onNext: { [weak self] in
				self?.tableView.reloadData()
			})
			.disposed(by: disposseBag)

		tableView.rx.itemDeleted
			.bind(to: viewModel.onDelete)
			.disposed(by: disposseBag)
	}
}
