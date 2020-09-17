//
//  SettingsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 10.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	var presenter: SettingsPresenterProtocol!

	var onAccount: (() -> Void)?
	var onTheme: (() -> Void)?

	lazy var imagePickerController: UIImagePickerController = {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		return imagePicker
	}()

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
			tableView.registerNib(cellType: PhotoTableViewCell.self)
			tableView.registerNib(cellType: RegularTableViewCell.self)
			tableView.registerNib(cellType: SwitchTableViewCell.self)
			tableView.registerNib(cellType: SettingsTableViewCell.self)
			tableView.registerNib(cellType: ColorTableViewCell.self)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.topItem?.title = "Settings"
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.numberOfRows(in: section)
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return presenter.numberOfSections
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellType = presenter.cellModel(at: indexPath.section, and: indexPath.row)

		switch cellType {
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
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelectTableViewCell(at: indexPath.section, and: indexPath.row)
		tableView.deselectRow(at: indexPath, animated: true)
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return presenter.titleForHeader(at: section)
	}
}

//MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
	func reloadData() {
		self.tableView.reloadData()
	}

	func didSelectPhotoCell() {
		if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
			present(imagePickerController, animated: true, completion: nil)
		}
	}
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension SettingsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

		if let image = info[.originalImage] as? UIImage {
			presenter.didSelectPhoto(image.pngData())
		}

		self.dismiss(animated: true)
	}
}
