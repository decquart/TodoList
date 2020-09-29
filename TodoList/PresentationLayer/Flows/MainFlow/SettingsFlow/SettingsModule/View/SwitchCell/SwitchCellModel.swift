//
//  SwitchCellModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 10.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

struct SwitchCellModel {
	let title: String
	let isOn: Bool
	let onSwitch: ((Bool) -> Void)?
}
