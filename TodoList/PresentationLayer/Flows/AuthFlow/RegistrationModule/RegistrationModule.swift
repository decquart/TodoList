//
//  RegistrationModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import RxSwift

class RegistrationModule {
	let disposeBag = DisposeBag()

	func build(onBack: (() -> Void)?) -> UIViewController {
		let view = RegistrationViewController.instantiate(storyboard: .registration)
		let repo = CDUserRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let viewModel = RegistrationViewModel(repository: repo, keychain: Keychain())

		viewModel.onBack
			.subscribe(onNext: {
				onBack?()
			})
			.disposed(by: disposeBag)

		view.viewModel = viewModel
		return view
	}
}
