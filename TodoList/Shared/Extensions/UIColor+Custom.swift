//
//  UIColor+Custom.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 12.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

@available(iOS 11, *)
extension UIColor {
	class var collectionViewBackgroundColor: UIColor! {
		return UIColor(named: "CollectionViewBackgroundColor")
	}

	class var selectedBorderColor: UIColor! {
		return UIColor(named: "SelectedBorderColor")
	}
}
