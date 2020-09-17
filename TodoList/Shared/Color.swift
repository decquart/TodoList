//
//  Color.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 24.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

enum Color: String {
	case customBlue = "CustomBlue"
	case customGreen = "CustomGreen"
	case customIndigo = "CustomIndigo"
	case customOrange = "CustomOrange"
	case customPink = "CustomPink"
	case customPurple = "CustomPurple"
	case customRed = "CustomRed"
	case customTeal = "CustomTeal"
	case customYellow = "CustomYellow"

	var uiColor: UIColor {
		guard let color = UIColor(named: self.rawValue) else {
			preconditionFailure("Please add \(self.rawValue) color to the Colors.xcassets file")
		}

		return color
	}
}
