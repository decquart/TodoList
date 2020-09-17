//
//  SettingsPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 04.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol SettingsPresenterProtocol {

	var interactor: SettingsInteractorInput! { get }
	var numberOfSections: Int { get }

	func viewDidLoad()
	func numberOfRows(in section: Int) -> Int
	func titleForHeader(at index: Int) -> String
	func didSelectTableViewCell(at section: Int, and row: Int)
	func cellModel(at section: Int, and row: Int) -> SettingsCellType
	func didSelectPhoto(_ photo: Data?)
}
