//
//  SettingsCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator {

	var onLogOut: (() -> Void)?

	override func start() {
		showSettingsViewController()
	}
}

// MARK: - Flows
private extension SettingsCoordinator {
	func showSettingsViewController() {
		let module = SettingsModule().build(onLogOut: onLogOut, onTheme: showThemeViewController(onApplyColor:)) 

		self.router.setRootModule(module, animated: true)
	}

	func showThemeViewController(onApplyColor: Completion?) {
		let vc = ThemesModule().build(onDismiss: router.dismiss, onApplyColor: onApplyColor)
		router.presentInteractiveScreen(vc)
	}
}
