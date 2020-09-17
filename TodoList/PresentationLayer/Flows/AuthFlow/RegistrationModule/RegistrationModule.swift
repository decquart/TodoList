//
//  RegistrationModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class RegistrationModule {
	func build(onBack: (() -> Void)?) -> UIViewController {
		let view = RegistrationViewController.instantiate(storyboard: .registration)
		let repo = CDUserRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let interactor = RegistrationInteractor(repository: repo, keychain: Keychain())
		let presenter = RegistrationPresenter(view: view, interactor: interactor)
		view.presenter = presenter
		interactor.output = presenter
		presenter.onBack = onBack
		return view
	}
}
