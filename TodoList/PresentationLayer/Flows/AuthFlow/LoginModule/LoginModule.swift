//
//  LoginModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class LoginModule {
	func build(onFinish: (() -> Void)?, onRegister: (() -> Void)?) -> UIViewController {

		let view = LoginViewController.instantiate(storyboard: .login)
		let repository = CDUserRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let viewModel = LoginViewModel(repository: repository,
									   keychain: Keychain(),
									   userSession: UserSession.default)


		//todo: need to figure out why it works with shared dispose bag
		viewModel.didSignIn
			.subscribe(onNext: {
				onFinish?()
			})
			.disposed(by: viewModel.disposeBag)

		viewModel.didSignUp
			.subscribe(onNext: {
				onRegister?()
			})
			.disposed(by: viewModel.disposeBag)

		let googleSignInService = GoogleSignInService.shared
		googleSignInService.configure(with: view, and: viewModel)

		view.viewModel = viewModel
		viewModel.googleSignInService = googleSignInService

		return view
	}
}
