//
//  CategoryListViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class CategoryListViewController: UIViewController {

	let disposeBag = DisposeBag()

	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			collectionView.rx
				.setDelegate(self)
				.disposed(by: disposeBag)
		}
	}

	var viewModel: CategoryListViewModel!
	let inset: CGFloat = 12.0

	override func viewDidLoad() {
		super.viewDidLoad()
		setupBindings()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.navigationController?.navigationBar.topItem?.title = "Categories"
		let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAddPressed))
		self.navigationController?.navigationBar.topItem?.rightBarButtonItem = item

		viewModel.loadCategories()
	}

	func setupBindings() {

		viewModel.categoryModels.bind(to: collectionView.rx.items(cellIdentifier: "CategoryCollectionViewCell", cellType: CategoryCollectionViewCell.self)) { row, category, cell in
			cell.configure(with: category)

			cell.editButton.rx.tap
				.subscribe(onNext: { [weak self] in
					self?.showEditCategoryAlertViewController(with: row)
				})
				.disposed(by: cell.disposeBag)
		}
		.disposed(by: disposeBag)

		collectionView.rx.itemSelected
			.subscribe(onNext: { [weak self] indexPath in
				self?.viewModel.onSelectIndexPath.onNext(indexPath)
			})
			.disposed(by: disposeBag)
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
}

// MARK: - Selectors
extension CategoryListViewController {
	@objc func buttonAddPressed() {
		viewModel.createCategory()
	}
}

// MARK: - Alert
extension CategoryListViewController {
	func showEditCategoryAlertViewController(with index: Int) {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
			self.viewModel.removeItem(at: index)
		}

		let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
			self.viewModel.editItem(at: index)
		}

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

		alert.addAction(deleteAction)
		alert.addAction(editAction)
		alert.addAction(cancelAction)
		self.present(alert, animated: true)
	}
}
