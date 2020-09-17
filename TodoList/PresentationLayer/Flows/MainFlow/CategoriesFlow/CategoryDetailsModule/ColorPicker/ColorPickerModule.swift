//
//  ColorPickerModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ColorPickerModule {
	func build(_ colorPickerOutput: ColorPickerPresenterOutput, selectedColor: Color?) -> UIView {
		let view = Bundle.main.loadNibNamed("ColorPickerView", owner: ColorPickerView.self, options: nil)?.first as! ColorPickerView
		let presenter = ColorPickerPresenter()
		view.presenter = presenter
		presenter.colorPickerOutput = colorPickerOutput
		presenter.selectedColor = selectedColor
		return view
	}
}
