//
//  LoginModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class LoginModule {
	func build(onFinish: (() -> Void)?, onRegister: (() -> Void)?) -> UIViewController {
		let view = LoginViewController.instantiate(storyboard: .login)
		let repository = CDUserRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let viewModel = LoginViewModel(repository: repository, keychain: Keychain(), userSession: UserSession.default)
		view.viewModel = viewModel


		let googleSignInService = GoogleSignInService.shared
		googleSignInService.configure(with: view, and: viewModel)

		viewModel.googleSignInService = googleSignInService

		return view
	}
}
