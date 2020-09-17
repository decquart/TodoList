//
//  ThemeService.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import UIKit

protocol ThemeServiceProtocol {
	var userInterfaceStyle: UIUserInterfaceStyle? { get set }
	var isDarkModeEnabled: Bool { get }
	func updateDarkMode()
	func setDarkModeVisble(_ isVisible: Bool)
	var applicationColor: Color { get set }
}

final class ThemeService {
	static let shared = ThemeService()
	private init() {}
}

// MARK: - ThemeServiceProtocol
extension ThemeService: ThemeServiceProtocol {
	var userInterfaceStyle: UIUserInterfaceStyle? {
		get { return UserDefaults.standard[#function] }
		set { UserDefaults.standard[#function] = newValue }
	}

	func updateDarkMode() {
		let theme = userInterfaceStyle ?? .light

		UIApplication.shared.windows.forEach {
			$0.overrideUserInterfaceStyle = theme
		}
	}

	func updateAppColor() {
		UIApplication.shared.windows.forEach {
			$0.tintColor = applicationColor.uiColor
			$0.tintAdjustmentMode = .normal
		}

		UISwitch.appearance().onTintColor = applicationColor.uiColor
	}

	func setDarkModeVisble(_ isVisible: Bool) {
		userInterfaceStyle = isVisible ? .dark : .light
		updateDarkMode()
	}

	var isDarkModeEnabled: Bool {
		guard let userInterfaceStyle = userInterfaceStyle else {
			return false
		}

		return userInterfaceStyle == .dark
	}

	var applicationColor: Color {
		get { return UserDefaults.standard[#function] ?? Color.customBlue }
		set {
			UserDefaults.standard[#function] = newValue
			updateAppColor()
		}
	}
}
