//
//  SceneDelegate.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	private var appCoordinator: AppCoordinator?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		seedInitialDataIfNeeded {
			self.configureMainView(with: windowScene)
			self.handleDeepLink(with: connectionOptions.shortcutItem)
		}
	}

	func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
		handleDeepLink(with: shortcutItem)
	}
}

private extension SceneDelegate {
	func configureMainView(with windowScene: UIWindowScene) {
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window!.windowScene = windowScene

		appCoordinator = AppCoordinator(window: window!)
		appCoordinator?.start()
		ThemeService.shared.updateDarkMode()
		ThemeService.shared.updateAppColor()
	}

	func handleDeepLink(with shortcutItem: UIApplicationShortcutItem?) {
		guard let item = shortcutItem, let deepLink = DeepLink(rawValue: item.type) else {
			return
		}

		appCoordinator?.handle(deepLink)
	}
}

private extension SceneDelegate {
	func seedInitialDataIfNeeded(completion: @escaping () -> Void) {
		let application = UIApplication.shared
		let repo = CDCategoryRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)

		guard application.isFirstLaunch else {
			completion()
			return
		}

		guard let url = Bundle.main.url(forResource: "Categories", withExtension: "json") else {
			completion()
			return
		}

		do {
			let data = try Data(contentsOf: url)
			let categories = try JSONDecoder().decode(Array<Category>.self, from: data)
			repo.add(categories) { success in
				if success { application.isFirstLaunch = false }
				completion()
			}
		} catch {
			completion()
			print("error in \(#function): \(error)")
		}
	}
}
