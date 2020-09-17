//
//  CategoryDetailsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 02.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class CategoryDetailsPresenter: CategoryDetailsPresenterProtocol {
	weak var view: CategoryDetailsViewProtocol!
	var interactor: CategoryDetailsInteractorInput

	var onDismiss: (() -> Void)?

	init(view: CategoryDetailsViewProtocol, interactor: CategoryDetailsInteractorInput) {
		self.view = view
		self.interactor = interactor
	}

	func saveButtonPressed(with viewModel: CategoryViewModel) {
		guard view.isNewCategory else {
			interactor.update(viewModel.mapToModel)
			return
		}

		interactor.create(viewModel.mapToModel)
	}

	func updateIcon(_ imagePath: String) {
		view.refreshIcon(imagePath)
	}
}

//MARK: - CategoryDetailsInteractorOutput
extension CategoryDetailsPresenter: CategoryDetailsInteractorOutput {
	func didCategoryPersist() {
		self.onDismiss?()
	}
}

extension CategoryDetailsPresenter: ColorPickerPresenterOutput {
	func updateColor(_ color: Color) {
		view.refreshColor(color)
	}
}
