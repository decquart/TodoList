//
//  InsetTextField.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 24.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

@IBDesignable
class InsetTextField: UITextField {
	@IBInspectable var insetX: CGFloat = 0
	@IBInspectable var insetY: CGFloat = 0

	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: insetX, dy: insetY)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: insetX, dy: insetY)
	}
}
