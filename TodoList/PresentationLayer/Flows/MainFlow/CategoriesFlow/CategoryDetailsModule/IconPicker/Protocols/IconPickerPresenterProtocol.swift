//
//  IconPickerPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol IconPickerPresenterProtocol: class {
	var view: IconPickerViewProtocol! { get }
	var imageNames: [String] { get }
	func updateIcon(at index: Int)
}
