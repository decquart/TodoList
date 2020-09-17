//
//  InteractivePresentationController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 12.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class InteractivePresentationController: UIPresentationController {

	private let yOffset: CGFloat = 160
	private var yStartPosition: CGFloat = 0
	private let yDismissOffset: CGFloat = 100

	private lazy var dimmingView: UIView = {
		guard let containerView = containerView else { return UIView() }

		let view = UIView(frame: containerView.bounds)
		view.backgroundColor = .black
		view.alpha = 0
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
		return view
	}()

	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

		presentedViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
		presentedViewController.view.layer.cornerRadius = presentedViewController.view.frame.width / 20
	}

	@objc func handlePan(_ gesture: UIPanGestureRecognizer) {
		guard let view = gesture.view, let presented = presentedView, let container = containerView else { return }

		let location = gesture.translation(in: view)

		switch gesture.state {
		case .began:
			self.yStartPosition = presented.frame.origin.y
		case .changed:
			presented.frame.origin.y = max(yStartPosition + location.y, yOffset)
		case .ended:
			if presented.frame.origin.y >= (container.frame.height - yDismissOffset) {
				presentedViewController.dismiss(animated: true, completion: nil)
			}
		default:
			break
		}
	}

	@objc func handleTap(_ gesture: UITapGestureRecognizer) {
		presentedViewController.dismiss(animated: true, completion: nil)
	}

	override var frameOfPresentedViewInContainerView: CGRect {
		guard let containerView = containerView else { return .zero }

		return CGRect(x: 0, y: containerView.bounds.height / 2, width: containerView.bounds.width, height: containerView.bounds.height - yOffset)
	}

	override func presentationTransitionWillBegin() {
		containerView?.addSubview(dimmingView)
		dimmingView.addSubview(presentedViewController.view)

		presentingViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
			self?.dimmingView.alpha = 0.7
		}, completion: nil)
	}

	override func dismissalTransitionWillBegin() {
		presentingViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
			self?.dimmingView.alpha = 0
		}, completion: nil)
	}

	override func dismissalTransitionDidEnd(_ completed: Bool) {
		if completed {
			dimmingView.removeFromSuperview()
		}
	}
}

final class InteractiveTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

	init(from presented: UIViewController, to presenting: UIViewController) {
		super.init()
	}

	func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		return InteractivePresentationController(presentedViewController: presented, presenting: presenting)
	}
}
