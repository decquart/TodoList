//
//  CategoryDetailsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class CategoryDetailsModule {
	func build(scope: Scope<CategoryViewModel>, onDismiss: (() -> Void)?) -> UIViewController {
		let view = CategoryDetailsViewController.instantiate(storyboard: .categoryDetails)
		let repository = CDCategoryRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let viewModel = CategoryDetailsViewModel(repository: repository, scope: scope)

		let iconsSubview = IconPickerModule().build(imagePath: scope.model?.imagePath)
		let colorsSubview = ColorPickerModule().build(selectedColor: scope.model?.color)

		view.viewModel = viewModel
		view.colorPickerView = colorsSubview
		view.iconPickerView = iconsSubview

		viewModel.onDismiss
			.subscribe(onNext: {
				onDismiss?()
			})
			.disposed(by: viewModel.disposeBag)

		iconsSubview.didSelectImageName
			.subscribe(onNext: {
				viewModel.selectedImage.onNext($0)
			})
			.disposed(by: viewModel.disposeBag)

		colorsSubview.onSelectColor
			.subscribe(onNext: {
				viewModel.selectedColor.onNext($0)
			})
			.disposed(by: viewModel.disposeBag)

		return view
	}
}
