//
//  CategoryDetailsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class CategoryDetailsModule {
	func build(scope: Scope<CategoryViewModel>, onDismiss: Completion?) -> UIViewController {
		let view = CategoryDetailsViewController.instantiate(storyboard: .categoryDetails)
		let repository = CDCategoryRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)

		let iconsSubview = IconPickerModule().build(imagePath: scope.model?.imagePath)
		let colorsSubview = ColorPickerModule().build(selectedColor: scope.model?.color)

		let viewModel = CategoryDetailsViewModel(repository: repository,
												 scope: scope,
												 didSelectImageName: iconsSubview.didSelectImageName,
												 onSelectColor: colorsSubview.onSelectColor)

		view.viewModel = viewModel
		view.colorPickerView = colorsSubview
		view.iconPickerView = iconsSubview

		viewModel.onDismiss = onDismiss

		return view
	}
}
