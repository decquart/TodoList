//
//  IconPickerViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol IconPickerViewProtocol: class {
	var presenter: IconPickerPresenterProtocol! { get }
	func iconDidSelect(_ imagePath: String)
}
