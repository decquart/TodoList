//
//  NSObject+UIColor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import Foundation

extension NSObject {
	var toColor: UIColor {
		guard let color = self as? UIColor else {
			return .clear
		}

		return color
	}
}
