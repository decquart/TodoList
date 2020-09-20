//
//  AuthCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class AuthCoordinator: BaseCoordinator {

	var onFinish: (() -> Void)?
	private let loginModule = LoginModule()
	private let registrationModule = RegistrationModule()

	override func start() {
		showLoginScreen()
	}
}

private extension AuthCoordinator {
	func showLoginScreen() {
		let module = loginModule.build(onFinish: onFinish,
										 onRegister: showRegistrationScreen)

		self.router.rootViewController.navigationBar.isHidden = true
		self.router.setRootModule(module, animated: false)
	}

	func showRegistrationScreen() {
		let module = registrationModule.build(onBack: router.pop)
		self.router.push(module)
	}
}
