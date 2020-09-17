//
//  UICollectionView+Wrapper.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 03.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

extension UICollectionView {
	func dequeue<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
		dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as! T
	}

	func registerNib<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
		register(UINib(nibName: cellType.reuseIdentifier, bundle: bundle ?? Bundle(for: T.self)), forCellWithReuseIdentifier: cellType.reuseIdentifier)
	}

	func register<T: UICollectionViewCell>(cellType: T.Type) {
		register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
	}
}
