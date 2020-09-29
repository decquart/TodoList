//
//  SettingsViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 24.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RxSwift

final class SettingsViewModel {

	enum SettingsError {
		case cantSavePhoto
	}
	
	private let session: UserSessionProtocol
	private let themeService: ThemeServiceProtocol
	private let repository: AnyRepository<User>

	let disposeBag = DisposeBag()
	let items = PublishSubject<[SettingsSection]>()

	let onSelectIndexPath = PublishSubject<IndexPath>()

//	let didLogOut = PublishSubject<Void>()
	var onLogOut: Completion?
	let onSelectPhotoCell = PublishSubject<Void>()

	var onTheme: ((Completion?) -> Void)?

	init(session: UserSessionProtocol, themeService: ThemeServiceProtocol, repository: AnyRepository<User>) {
		self.session = session
		self.themeService = themeService
		self.repository = repository

		onSelectIndexPath.withLatestFrom(items) { indexPath, items  in
			return items[indexPath.section].items[indexPath.row]
		}
		.subscribe(onNext: { [weak self] in
			self?.didSelectTableViewCell($0)
		})
		.disposed(by: disposeBag)
	}

	func reloadData() {
		fetchCurrentUser()
			.flatMap { [unowned self] user -> Observable<[SettingsSection]> in
				guard let user = user else {
					return .just(sectionsForUnAuthorizedUser)
				}

				return .just(self.sectionsForAuthorizedUser(user))
			}
			.subscribe(onNext: { [unowned self] in
				self.items.onNext($0)
			})
			.disposed(by: disposeBag)

	}

	func fetchCurrentUser() -> Observable<User?> {

		return Observable.create { [weak self] observer -> Disposable in
			let disposable = Disposables.create()

			guard let user = self?.session.currentUser else {
				observer.onNext(nil)
				return disposable
			}

			let predicate = NSPredicate(format: "name = %@", user)

			self?.repository.fetch(where: predicate) { result in
				if case let .success(users) = result, let fetchedUser = users.first {
					observer.onNext(fetchedUser)
				}
			}

			return disposable
		}
	}

	func saveUserImage(_ imageData: Data?) {

		fetchCurrentUser()
			.flatMap { [unowned self] user -> Observable<Bool> in
				return self.updatePhoto(imageData, for: user)
			}
			.subscribe(onNext: { [weak self] success in
				if success {
					self?.reloadData()
				}
			})
			.disposed(by: disposeBag)
	}

	private func updatePhoto(_ imageData: Data?, for user: User?) -> Observable<Bool> {
		return Observable.create { observer in
			let disposable = Disposables.create()

			guard var user = user else {
				observer.onNext(false)
				return disposable
			}

			user.image = imageData
			self.repository.update(user) { success in
				return observer.onNext(success)
			}

			return disposable
		}
	}

	private func didSelectTableViewCell(_ cell: SettingsCellType) {
		switch cell {
		case .icon(_, let type):
			if type == .logOut {
				session.logOut()
				onLogOut?()
			}
		case .color:
			onTheme?{ [weak self] in
				self?.reloadData()
			}
		case .photo(_, let type):
			if type == .profile {
				onSelectPhotoCell.onNext(())
			}
		default:
			break
		}
	}

	private var sectionsForUnAuthorizedUser: [SettingsSection] {
		return [
			SettingsSection(title: "Theme", items: [
				.switch(SwitchCellModel(title: "Dark Mode", isOn: themeService.isDarkModeEnabled, onSwitch: themeService.setDarkModeVisble(_:)), type: .darkMode),
				.color(ColorCellModel(title: "Application color", color: themeService.applicationColor))
			]),
			SettingsSection(title: "", items: [.icon(SettingsCellModel(title: "Log In", imageName: "person"), type: .logOut)])
		]
	}

	func sectionsForAuthorizedUser(_ user: User) -> [SettingsSection] {
		return [
			SettingsSection(title: "User Info", items: [.photo(PhotoCellModel(name: user.name, imageData: user.image), type: .profile)]),
			SettingsSection(title: "Email", items: [.regular(RegularSettingsCellModel(title: user.email), type: .email)]),
			SettingsSection(title: "Theme", items: [
				.switch(SwitchCellModel(title: "Dark Mode", isOn: themeService.isDarkModeEnabled, onSwitch: themeService.setDarkModeVisble(_:)), type: .darkMode),
				.color(ColorCellModel(title: "Application color", color: themeService.applicationColor))
			]),
			SettingsSection(title: "", items: [.icon(SettingsCellModel(title: "Log Out", imageName: "lock"), type: .logOut)])
		]
	}
}
