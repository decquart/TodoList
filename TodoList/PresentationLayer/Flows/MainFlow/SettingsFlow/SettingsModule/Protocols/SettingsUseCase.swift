//
//  SettingsUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol SettingsInteractorInput: class {
	var user: User? { get }
	var output: SettingsInteractorOutput? { get }

	var isCurrentUserExists: Bool { get }
	var isDarkModeEnabled: Bool { get }
	var applicationColor: Color { get }
	func setDarkMode(_ isOn: Bool)
	func saveUserImage(_ imageData: Data?)

	func fetchCurrentUser()
	func logOut()
}

protocol SettingsInteractorOutput: class {
	func didUserFetch(_ user: User)
	func didLogOut()
	func didUserImageSave()
}
