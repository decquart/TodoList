//
//  ThemesUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ThemesInteractorInput: class {
	func setDefaultAppColor()
	func saveSelectedColor(color: Color)
	func applySelectedColor()
}

protocol ThemesInteractorOutput: class {
	func didSaveColor(_ color: Color)
	func didApplyColor()
}
