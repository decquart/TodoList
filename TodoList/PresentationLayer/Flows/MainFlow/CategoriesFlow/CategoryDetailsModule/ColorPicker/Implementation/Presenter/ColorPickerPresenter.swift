//
//  ColorPickerPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class ColorPickerPresenter: ColorPickerPresenterProtocol {

	weak var colorPickerOutput: ColorPickerPresenterOutput?

	var selectedColor: Color?

	var selectedColorIndex: Int {
		guard let color = selectedColor else {
			return 0
		}

		return colors.firstIndex(of: color) ?? 0
	}

	var colors: [Color] {
		return [.customBlue, .customGreen, .customIndigo, .customOrange, .customPink, .customPurple, .customRed, .customTeal, .customYellow]
	}

	func didSelectColor(at index: Int) {
		selectedColor = colors[index]
		colorPickerOutput?.updateColor(colors[index])
	}
}
