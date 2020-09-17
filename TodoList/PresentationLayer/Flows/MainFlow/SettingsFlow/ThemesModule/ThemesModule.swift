//
//  ThemesModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 17.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ThemesModule {
	func build(onDismiss: Completion?, onApplyColor: Completion?) -> UIViewController {
		let view = ThemesViewController.instantiate(storyboard: .themes)
		let interactor = ThemesInteractor(themeService: ThemeService.shared)
		let presenter = ThemesPresenter(view: view, interactor: interactor)
		let selectedColor = ThemeService.shared.applicationColor
		let colorPickerView = ColorPickerModule().build(presenter, selectedColor: selectedColor)

		presenter.onDismiss = onDismiss
		presenter.onApplyColor = onApplyColor
		view.colorPickerView = colorPickerView
		view.presenter = presenter
		interactor.output = presenter
		return view
	}
}
