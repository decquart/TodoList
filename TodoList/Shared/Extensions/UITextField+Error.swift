//
//  UITextField+Error.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

extension UITextField {

	func setErrorMessage(_ errorMessage: String) {
		self.text = ""
		self.placeholder = errorMessage
		guard let attributedPlaceholder = attributedPlaceholder else { return }
		let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: .red]
		self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
	}
}
