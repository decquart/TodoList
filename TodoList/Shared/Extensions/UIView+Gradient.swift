//
//  UIView+Gradient.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

enum GradientType {
	case login(startPoint: CGPoint, endPoint: CGPoint)
}

extension UIView {
	func applyGradient(for gradientType: GradientType) {
		let gradient = CAGradientLayer()
		gradient.frame = self.bounds

		switch gradientType {
		case .login(let startPoint, let endPoint):
			gradient.startPoint = startPoint
			gradient.endPoint = endPoint
			gradient.colors = [UIColor(red: 25/255, green: 104/255, blue: 231/255, alpha: 1).cgColor, UIColor(red: 109/255, green: 34/255, blue: 243/255, alpha: 1).cgColor]
		}

		self.layer.insertSublayer(gradient, at: 0)
	}
}
