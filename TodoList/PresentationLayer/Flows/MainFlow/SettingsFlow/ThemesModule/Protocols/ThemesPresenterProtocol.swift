//
//  ThemesPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ThemesPresenterProtocol: class {
	var interactor: ThemesInteractorInput! { get }
	var view: ThemesViewProtocol! { get }

	func viewDodLoad()
	func applyTheme()
	func close()
}
