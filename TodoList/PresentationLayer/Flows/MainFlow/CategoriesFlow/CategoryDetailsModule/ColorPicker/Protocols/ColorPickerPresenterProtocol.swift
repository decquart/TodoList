//
//  ColorPickerPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ColorPickerPresenterProtocol: class {
	var colorPickerOutput: ColorPickerPresenterOutput? { get }
	var colors: [Color] { get }
	var selectedColorIndex: Int { get }

	func didSelectColor(at index: Int)
}

protocol ColorPickerPresenterOutput: class {
	func updateColor(_ color: Color)
}
