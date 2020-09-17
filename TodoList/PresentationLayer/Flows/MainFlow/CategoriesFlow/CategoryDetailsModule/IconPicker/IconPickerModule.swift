//
//  IconPickerModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class IconPickerModule {
	func build(_ detailsPresenter: CategoryDetailsPresenterProtocol) -> UIView {
		let presenter = IconPickerPresenter()
		let view = Bundle.main.loadNibNamed("IconPickerView", owner: IconPickerView.self, options: nil)?.first as! IconPickerView
		view.presenter = presenter
		presenter.view = view
		presenter.detailsPresenter = detailsPresenter
		return view
	}
}
