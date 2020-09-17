//
//  RouterType.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

typealias Completion = () -> Void

protocol Routable: class {
	var rootViewController: UINavigationController { get }
	
	func present(_ module: UIViewController, animated: Bool, completion: Completion?)
	func push(_ module: UIViewController, animated: Bool, completion: Completion?)
	func pop(animated: Bool)
	func dismiss(animated: Bool, completion: Completion?)
	func setRootModule(_ module: UIViewController, hideBar: Bool, animated: Bool)
	func popToRoot(animated: Bool)
}

extension Routable {
	func present(_ module: UIViewController) {
		self.present(module, animated: true)
	}

	func present(_ module: UIViewController, animated: Bool) {
		self.present(module, animated: animated, completion: nil)
	}

	func presentInteractiveScreen(_ module: UIViewController) {

		guard let fromVC = rootViewController.topViewController else {
			return
		}

		let interactiveTransitionDelegate = InteractiveTransitionDelegate(from: fromVC, to: module)
		module.transitioningDelegate = interactiveTransitionDelegate
		module.modalPresentationStyle = .custom

		self.present(module)
	}

	func push(_ module: UIViewController) {
		self.push(module, animated: true)
	}

	func push(_ module: UIViewController, animated: Bool) {
		self.push(module, animated: animated, completion: nil)
	}

	func pop() {
		self.pop(animated: true)
	}

	func dismiss() {
		self.dismiss(animated: true, completion: nil)
	}

	func setRootModule(_ module: UIViewController, animated: Bool) {
		self.setRootModule(module, hideBar: false, animated: animated)
	}
}
