//
//  UICollectionViewCell+ReuseIdentifier.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 03.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
