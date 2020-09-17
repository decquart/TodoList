//
//  SettingsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsModule {
	func build(onLogOut: Completion?, onTheme: ((Completion?) -> Void)?) -> UIViewController {
		let view = SettingsViewController.instantiate(storyboard: .settings)
		let repository = CDUserRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let interactor = SettingsInteractor(session: UserSession.default,
											themeService: ThemeService.shared,
											repository: repository)
		let presenter = SettingsPresenter(interactor: interactor, view: view)
		presenter.onTheme = onTheme
		presenter.onLogOut = onLogOut
		view.presenter = presenter
		interactor.output = presenter
		return view
	}
}
