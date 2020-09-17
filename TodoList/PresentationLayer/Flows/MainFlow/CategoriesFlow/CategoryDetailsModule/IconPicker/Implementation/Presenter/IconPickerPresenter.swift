//
//  IconPickerPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class IconPickerPresenter: IconPickerPresenterProtocol {
	weak var view: IconPickerViewProtocol!
	weak var detailsPresenter: CategoryDetailsPresenterProtocol?
	
	let imageNames = ["shopping", "todo", "work"]

	func updateIcon(at index: Int) {
		detailsPresenter?.updateIcon(imageNames[index])
	}
}
