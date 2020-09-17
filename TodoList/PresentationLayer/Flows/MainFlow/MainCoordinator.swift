//
//  MainCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 30.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator {

	lazy var tabBarController: TabBarController = {
		TabBarController(delegate: self)
	}()

	private var settingsCoordinator: SettingsCoordinator?
	private var categoryCoordinator: CategoiesCoordinator?

	var onFinish: (() -> Void)?

	override func start() {
		initialize()
		runCategoriesFlow()
	}

	func handle(_ link: DeepLink) {
		switch link {
		case .createCategory:
			showCategories()
		}
	}

	func runCategoriesFlow() {
		let categoryCoordinator = CategoiesCoordinator()
		let vc = categoryCoordinator.router.rootViewController
		tabBarController.set(vc, at: .categories)

		addDependency(categoryCoordinator)
		categoryCoordinator.start()

		self.categoryCoordinator = categoryCoordinator
	}

	func runSettingsFlow() {
		let settingsCoordinator = SettingsCoordinator()
		let vc = settingsCoordinator.router.rootViewController
		tabBarController.set(vc, at: .settings)

		settingsCoordinator.onLogOut = { [unowned self] in
			self.onFinish?()
		}

		addDependency(settingsCoordinator)
		settingsCoordinator.start()

		self.settingsCoordinator = settingsCoordinator
	}
}

//MARK: - UITabBarControllerDelegate
extension MainCoordinator: UITabBarControllerDelegate {

	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		childCoordinators = []

		tabBarController.selectedIndex == TabItem.categories.rawValue
			? runCategoriesFlow()
			: runSettingsFlow()
	}
}

private extension MainCoordinator {
	func initialize() {
		self.settingsCoordinator = SettingsCoordinator()
		self.categoryCoordinator = CategoiesCoordinator()

		let categoryVC = categoryCoordinator!.router.rootViewController
		let settingsVC = settingsCoordinator!.router.rootViewController

		categoryVC.tabBarItem = tabBarController.items[.categories]
		settingsVC.tabBarItem = tabBarController.items[.settings]
		tabBarController.viewControllers = [categoryVC, settingsVC]
	}

	func showCategories() {
		tabBarController.selectTab(.categories)
		categoryCoordinator?.handle(.createCategory)
	}
}
