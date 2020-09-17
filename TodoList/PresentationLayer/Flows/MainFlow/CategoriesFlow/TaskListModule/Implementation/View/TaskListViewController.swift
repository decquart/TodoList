//
//  TaskListViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
	var presenter: TaskListPresenterProtocol!

	@IBOutlet weak private var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Complete All", style: .plain, target: self, action: #selector(completeAll))
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.navigationItem.title = "Tasks"
		presenter?.loadTasks()
	}
}

// MARK: - TaskListViewInput
extension TaskListViewController: TaskListViewProtocol {
	func refreshTasks() {
		tableView.reloadData()
	}
}

// MARK: - Selectors
extension TaskListViewController {
	@objc func completeAll() {
		presenter?.didCompleteAll()
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(cellType: TaskCell.self, for: indexPath)
		guard let task = presenter?.task(at: indexPath) else {
			return UITableViewCell()
		}

		cell.configure(with: task)
		cell.checkButtonPressedCallback = { [weak self] in
			self?.presenter.buttonCompletePressed(at: indexPath.row)
		}

		cell.importantButtonPressedCallback = { [weak self] in
			self?.presenter.buttonImportantPressed(at: indexPath.row)
		}

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter?.didSelect(at: indexPath)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension TaskListViewController {
	@IBAction func addButtonPressed(_ sender: UIButton) {
		presenter?.addButtonPressed()
	}
}
