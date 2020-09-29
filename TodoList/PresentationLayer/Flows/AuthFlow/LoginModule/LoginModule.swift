//
//  LoginModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class LoginModule {
	func build(onFinish: Completion?, onRegister: Completion?) -> UIViewController {

		let view = LoginViewController.instantiate(storyboard: .login)
		let repository = CDUserRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let viewModel = LoginViewModel(repository: repository,
									   keychain: Keychain(),
									   userSession: UserSession.default)

		let googleSignInService = GoogleSignInService.shared
		googleSignInService.configure(with: view, and: viewModel)

		view.viewModel = viewModel
		viewModel.googleSignInService = googleSignInService
		viewModel.onFinish = onFinish
		viewModel.onRegister = onRegister

		return view
	}
}
