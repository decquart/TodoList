//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

	private let window: UIWindow

	private let userSession = UserSession.default

	init(window: UIWindow) {
		self.window = window

		super.init()
	}

	override func start() {
		if userSession.isAuthorized {
			runMainFlow()
		} else {
			runAuthFlow()
		}
	}

	func handle(_ link: DeepLink) {
		guard userSession.isAuthorized else {
			runAuthFlow()
			return
		}

		switch link {
		case .createCategory:
			let coordinator = runMainFlow()
			coordinator.handle(link)
		}
	}

	@discardableResult
	private func runMainFlow() -> MainCoordinator {
		let mainCoordinator = MainCoordinator()
		mainCoordinator.onFinish = { [unowned self, unowned mainCoordinator] in
			self.removeDependency(mainCoordinator)
			self.start()
		}

		addDependency(mainCoordinator)
		mainCoordinator.start()
		configureWindow(with: mainCoordinator.tabBarController, animationOption: .flipFromRight)
		return mainCoordinator
	}

	private func runAuthFlow() {
		let authCoordinator = AuthCoordinator()
		authCoordinator.onFinish = { [unowned self, unowned authCoordinator] in
			self.removeDependency(authCoordinator)
			self.start()
		}

		addDependency(authCoordinator)
		authCoordinator.start()
		configureWindow(with: authCoordinator.router.rootViewController, animationOption: .flipFromLeft)
	}
}

private extension AppCoordinator {

	enum WindowAnimation {
		case none
		case flipFromRight
		case flipFromLeft
	}

	func configureWindow(with rootViewController: UIViewController, animationOption: WindowAnimation = .none) {
		self.window.rootViewController = rootViewController
		self.window.makeKeyAndVisible()

		switch animationOption {
		case .flipFromLeft:
			UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
		case .flipFromRight:
			UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
		default:
			break
		}
	}
}
