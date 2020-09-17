//
//  UITableView+Wrapper.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

extension UITableView {
	func dequeue<T: UITableViewCell>(cellType: T.Type) -> T? {
		return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as? T
	}

	func dequeue<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
			fatalError("Can not dequeue \(cellType.reuseIdentifier), for indexPath: \(indexPath)")
		}

		return cell
	}

	func register<T: UITableViewCell>(cellType: T.Type) {
		register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
	}

	func registerNib<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
		register(UINib(nibName: cellType.reuseIdentifier, bundle: bundle ?? Bundle(for: T.self)), forCellReuseIdentifier: cellType.reuseIdentifier)
	}
}
