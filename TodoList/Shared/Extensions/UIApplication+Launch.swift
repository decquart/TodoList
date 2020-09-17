//
//  UIApplication+Launch.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 12.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

extension UIApplication {
	var isFirstLaunch: Bool {
		get { return UserDefaults.standard[#function] ?? true }
		set { UserDefaults.standard[#function] = newValue }
	}
}
