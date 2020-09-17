//
//  ThemesInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class ThemesInteractor {
	weak var output: ThemesInteractorOutput?
	private var themeService: ThemeServiceProtocol
	private var selectedColor: Color = .customBlue

	init(themeService: ThemeServiceProtocol) {
		self.themeService = themeService
	}
}

//MARK: - ThemesInteractorInput
extension ThemesInteractor: ThemesInteractorInput {
	func setDefaultAppColor() {
		selectedColor = themeService.applicationColor

		output?.didSaveColor(selectedColor)
	}

	func saveSelectedColor(color: Color) {
		selectedColor = color

		output?.didSaveColor(color)
	}

	func applySelectedColor() {
		themeService.applicationColor = selectedColor
		output?.didApplyColor()
	}
}
