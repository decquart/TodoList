//
//  SettingsViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol SettingsViewProtocol: class {
	var presenter: SettingsPresenterProtocol! { get }

	func reloadData()
	func didSelectPhotoCell()
}
