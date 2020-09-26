//
//  SettingsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 10.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SettingsViewController: UIViewController, UITableViewDelegate {
	var viewModel: SettingsViewModel!

	var onAccount: (() -> Void)?
	var onTheme: (() -> Void)?

	let disposeBag = DisposeBag()

	lazy var imagePickerController: UIImagePickerController = {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		return imagePicker
	}()

	private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingsSection>(
		configureCell: { dataSource, tableView, indexPath, item in

			switch item {
			case .photo(let model, _):
				let cell = tableView.dequeue(cellType: PhotoTableViewCell.self, for: indexPath)
				cell.configure(with: model)
				return cell
			case .regular(let model, _):
				let cell = tableView.dequeue(cellType: RegularTableViewCell.self, for: indexPath)
				cell.configure(with: model)
				return cell
			case .switch(let model, _):
				let cell = tableView.dequeue(cellType: SwitchTableViewCell.self, for: indexPath)
				cell.configure(with: model)
				return cell
			case .icon(let model, _):
				let cell = tableView.dequeue(cellType: SettingsTableViewCell.self, for: indexPath)
				cell.configure(with: model)
				return cell
			case .color(let model):
				let cell = tableView.dequeue(cellType: ColorTableViewCell.self, for: indexPath)
				cell.configure(with: model)
				return cell
			}
	})


	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.registerNib(cellType: PhotoTableViewCell.self)
			tableView.registerNib(cellType: RegularTableViewCell.self)
			tableView.registerNib(cellType: SwitchTableViewCell.self)
			tableView.registerNib(cellType: SettingsTableViewCell.self)
			tableView.registerNib(cellType: ColorTableViewCell.self)

			tableView.rx
				.setDelegate(self)
				.disposed(by: disposeBag)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupBindings()
		viewModel.reloadData()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.topItem?.title = "Settings"
		self.navigationController?.navigationBar.sizeToFit()
	}

	func setupBindings() {
		viewModel.items
			.bind(to: tableView.rx.items(dataSource: dataSource))
			.disposed(by: disposeBag)

		dataSource.titleForHeaderInSection = { dataSource, index in
			return dataSource.sectionModels[index].title
		}

		tableView.rx.itemSelected
			.subscribe(onNext: { [weak self] in
				self?.tableView.deselectRow(at: $0, animated: false)
				self?.viewModel.onSelectIndexPath.onNext($0)
			})
			.disposed(by: disposeBag)

		viewModel.onSelectPhotoCell
			.subscribe(onNext: { [weak self] in
				self?.presentImagePickerController()
			})
			.disposed(by: disposeBag)
	}

	func presentImagePickerController() {
		if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
			present(imagePickerController, animated: true, completion: nil)
		}
	}
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension SettingsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

		if let image = info[.originalImage] as? UIImage {
			viewModel.saveUserImage(image.pngData())
		}

		self.dismiss(animated: true)
	}
}
