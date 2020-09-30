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
		let colorsSubview = ColorPickerModule().build(selectedColor: ThemeService.shared.applicationColor)
		let viewModel = ThemesViewModel(themeService: ThemeService.shared, onSelectColor: colorsSubview.onSelectColor)

		view.colorPickerView = colorsSubview
		view.viewModel = viewModel

		viewModel.onDismiss = onDismiss
		viewModel.onApplyColor = onApplyColor

		return view
	}
}
