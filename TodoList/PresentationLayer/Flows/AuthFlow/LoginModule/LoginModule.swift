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
		let interactor = LoginInteractor(repository: repository,
										 keychain: Keychain(),
										 userSession: UserSession.default)

		let presenter = LoginPresenter(view: view, interactor: interactor)
		let googleSignInService = GoogleSignInService.shared
		googleSignInService.configure(with: view, and: interactor)

		view.presenter = presenter
		presenter.onFinish = onFinish
		presenter.onRegister = onRegister
		interactor.output = presenter
		interactor.googleSignInService = googleSignInService

		return view
	}
}
