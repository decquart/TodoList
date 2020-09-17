//
//  TabBarController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

enum TabItem: Int {
	case categories
	case settings
}

final class TabBarController: UITabBarController {
	convenience init(delegate: UITabBarControllerDelegate) {
		self.init()
		self.delegate = delegate
	}

	var items: [TabItem: UITabBarItem] {
		return [
			.categories: UITabBarItem(title: "Categories",
									  image: UIImage(systemName: "pencil.circle.fill"),
									  tag: TabItem.categories.rawValue),
			.settings: UITabBarItem(title: "Settings",
									image: UIImage(systemName: "gear"),
									tag: TabItem.settings.rawValue)
		]
	}

	func selectTab(_ tab: TabItem) {
		self.selectedIndex = tab.rawValue
	}

	func set(_ vc: UIViewController, at index: TabItem) {
		guard let viewControllers = self.viewControllers, viewControllers.count > index.rawValue else {
			preconditionFailure("Failure: 'TabBarController.viewControllers' property should be initialized!")
		}

		vc.tabBarItem = items[index]
		self.viewControllers?[index.rawValue] = vc
	}
}
