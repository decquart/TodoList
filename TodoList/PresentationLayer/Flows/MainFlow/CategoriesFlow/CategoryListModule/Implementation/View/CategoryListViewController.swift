//
//  CategoryListViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController {
	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			collectionView.delegate = self
			collectionView.dataSource = self
		}
	}

	var presenter: CategoryListPresenterProtocol!
	let inset: CGFloat = 12.0

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.navigationController?.navigationBar.topItem?.title = "Categories"
		let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAddPressed))
		self.navigationController?.navigationBar.topItem?.rightBarButtonItem = item
		presenter.loadCategories()
	}
}

// MARK: - CategoryListViewProtocol
extension CategoryListViewController: CategoryListViewProtocol {
	func reload() {
		self.collectionView.reloadData()
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CategoryListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.categoriesCount
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeue(cellType: CategoryCollectionViewCell.self, for: indexPath)
		let vm = presenter.category(at: indexPath.row)
		let tasksCount = presenter.tasksCount(at: indexPath.row)

		cell.configure(with: vm, tasksCount: tasksCount) { [weak self] in
			self?.showEditCategoryAlertViewController(with: indexPath.row)
		}
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryListViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.bounds.width / 2) - inset * 2

		return CGSize(width: width, height: width)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter.didSelectCategory(with: indexPath.row)
	}
}

// MARK: - Selectors
extension CategoryListViewController {
	@objc func buttonAddPressed() {
		presenter.addCategoryButtonPressed()
	}
}

// MARK: - Alert
extension CategoryListViewController {
	func showEditCategoryAlertViewController(with index: Int) {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
			self.presenter.deleteButtonPressed(with: index)
		}

		let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
			self.presenter.editButtonPressed(with: index)
		}

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

		alert.addAction(deleteAction)
		alert.addAction(editAction)
		alert.addAction(cancelAction)
		self.present(alert, animated: true)
	}
}
