//
//  SettingsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 04.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum SettingsCellType {
	case photo(PhotoCellModel, type: PhotoCellType)
	case regular(RegularSettingsCellModel, type: RegularCellType)
	case icon(SettingsCellModel, type: IconCellType)
	case `switch`(SwitchCellModel, type: SwitchCellType)
	case color(ColorCellModel)

	enum IconCellType {
		case logOut
	}

	enum PhotoCellType {
		case profile
	}

	enum RegularCellType {
		case email
	}

	enum SwitchCellType {
		case darkMode
	}
}

struct SettingsSection {
	let title: String
	let cells: [SettingsCellType]
}

final class SettingsPresenter: SettingsPresenterProtocol {
	var onAccount: (() -> Void)?
	var onTheme: ((Completion?) -> Void)?
	var onLogOut: (() -> Void)?

	let interactor: SettingsInteractorInput!
	weak var view: SettingsViewProtocol!

	init(interactor: SettingsInteractorInput, view: SettingsViewProtocol) {
		self.interactor = interactor
		self.view = view
	}

	func viewDidLoad() {
		if interactor.isCurrentUserExists {
			interactor.fetchCurrentUser()
		}
	}

	private var sectionsForAuthorizedUser: [SettingsSection] {
		return [
			SettingsSection(title: "User Info", cells: [.photo(PhotoCellModel(name: interactor.user?.name ?? "", imageData: interactor.user?.image), type: .profile)]),
			SettingsSection(title: "Email", cells: [.regular(RegularSettingsCellModel(title: interactor.user?.email ?? ""), type: .email)]),
			SettingsSection(title: "Theme", cells: [
				.switch(SwitchCellModel(title: "Dark Mode", isOn: interactor.isDarkModeEnabled, onSwitch: interactor.setDarkMode(_:)), type: .darkMode),
				.color(ColorCellModel(title: "Application color", color: interactor.applicationColor))
			]),
			SettingsSection(title: "", cells: [.icon(SettingsCellModel(title: "Log Out", imageName: "lock"), type: .logOut)])
		]
	}

	private var sectionsForUnAuthorizedUser: [SettingsSection] {
		return [
			SettingsSection(title: "Theme", cells: [
				.switch(SwitchCellModel(title: "Dark Mode", isOn: interactor.isDarkModeEnabled, onSwitch: interactor.setDarkMode(_:)), type: .darkMode),
				.color(ColorCellModel(title: "Application color", color: interactor.applicationColor))
			]),
			SettingsSection(title: "", cells: [.icon(SettingsCellModel(title: "Log In", imageName: "person"), type: .logOut)])
		]
	}

	var sections: [SettingsSection] {
		return interactor.isCurrentUserExists
			? sectionsForAuthorizedUser
			: sectionsForUnAuthorizedUser
	}

	var numberOfSections: Int {
		return sections.count
	}

	func numberOfRows(in section: Int) -> Int {
		return sections[section].cells.count
	}

	func cellModel(at section: Int, and row: Int) -> SettingsCellType {
		return sections[section].cells[row]
	}

	func titleForHeader(at index: Int) -> String {
		return sections[index].title
	}

	func didSelectTableViewCell(at section: Int, and row: Int) {
		let cellType = sections[section].cells[row]

		switch cellType {
		case .icon(_, let type):
			if type == .logOut {
				interactor.logOut()
			}
		case .color(_):
			onTheme?{ [weak self] in
				self?.view.reloadData()
			}
		case .photo(_, let type):
			if type == .profile {
				view.didSelectPhotoCell()
			}
		default:
			break
		}
	}

	func didSelectPhoto(_ photo: Data?) {
		interactor.saveUserImage(photo)
	}
}

//MARK: - SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {
	func didUserFetch(_ user: User) {
		view.reloadData()
	}

	func didLogOut() {
		onLogOut?()
	}

	func didUserImageSave() {
		view.reloadData()
	}
}
