//
//  UIView+Constraints.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 04.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

extension UIView {
	func add(_ view: UIView, top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
		view.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(view)

		view.topAnchor.constraint(equalTo: self.topAnchor, constant: top).isActive = true
		view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left).isActive = true
		view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: right).isActive = true
		view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom).isActive = true
	}
}
