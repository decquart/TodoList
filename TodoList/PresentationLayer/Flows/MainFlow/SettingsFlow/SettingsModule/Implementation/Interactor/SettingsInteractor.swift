//
//  SettingsInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class SettingsInteractor {
	weak var output: SettingsInteractorOutput?
	private let session: UserSessionProtocol
	private let themeService: ThemeServiceProtocol
	private let repository: AnyRepository<User>
	private(set) var user: User?

	init(session: UserSessionProtocol, themeService: ThemeServiceProtocol, repository: AnyRepository<User>) {
		self.session = session
		self.themeService = themeService
		self.repository = repository
	}
}

//MARK: - SettingsInteractorInput
extension SettingsInteractor: SettingsInteractorInput {
	var isCurrentUserExists: Bool {
		return session.currentUser != nil
	}

	var isDarkModeEnabled: Bool {
		return themeService.isDarkModeEnabled
	}

	var applicationColor: Color {
		return themeService.applicationColor
	}

	func setDarkMode(_ isOn: Bool) {
		themeService.setDarkModeVisble(isOn)
	}

	func fetchCurrentUser() {
		let predicate = NSPredicate(format: "name = %@", session.currentUser!)

		repository.fetch(where: predicate) { [weak self] result in
			if case let .success(users) = result, let fetchedUser = users.first {
				self?.user = fetchedUser
				self?.output?.didUserFetch(fetchedUser)
			}
		}
	}

	func logOut() {
		session.logOut()
		output?.didLogOut()
	}

	func saveUserImage(_ imageData: Data?) {
		guard var user = user else {
			return
		}
		user.image = imageData

		repository.update(user) { [weak self] success in
			if success {
				self?.user = user
				self?.output?.didUserImageSave()
			}
		}
	}
}
