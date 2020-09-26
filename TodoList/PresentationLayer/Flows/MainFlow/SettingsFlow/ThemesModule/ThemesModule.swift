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
		let viewModel = ThemesViewModel(themeService: ThemeService.shared)
		let colorsSubview = ColorPickerModule().build(selectedColor: ThemeService.shared.applicationColor)

		view.colorPickerView = colorsSubview
		view.viewModel = viewModel

		colorsSubview.onSelectColor
			.subscribe(onNext: {
				viewModel.selectedColor.onNext($0)
			})
			.disposed(by: viewModel.disposeBag)

		viewModel.didApplyColor
			.subscribe(onNext: { _ in 
				onApplyColor?()
			})
			.disposed(by: viewModel.disposeBag)

		viewModel.onDismiss
			.subscribe(onNext: {
				onDismiss?()
			})
			.disposed(by: viewModel.disposeBag)

		return view
	}
}
