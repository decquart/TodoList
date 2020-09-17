//
//  UITableViewCell+ReuseIdentifier.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

extension UITableViewCell {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
