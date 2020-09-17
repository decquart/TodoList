//
//  Storyboarded.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 30.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

enum Storyboard: String {
	case main = "Main"
	case categoryDetails = "CategoryDetails"
	case task = "Task"
	case taskDetails = "TaskDetails"
	case settings = "Settings"
	case accountInfo = "AccountInfo"
	case themes = "Themes"
	case login = "Login"
	case registration = "Registration"
}

extension UIViewController {
	static func instantiate(storyboard: Storyboard) -> Self {
		return instantiate(in: UIStoryboard(name: storyboard.rawValue, bundle: nil), identifire: nameOfClass())
	}
}

private extension UIViewController {
	static func instantiate<T: UIViewController>(in storyboard: UIStoryboard, identifire: String) -> T {
		return storyboard.instantiateViewController(identifier: identifire) as! T
	}
}
