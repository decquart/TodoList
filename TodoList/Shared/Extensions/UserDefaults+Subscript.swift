//
//  UserDefaults+Subscript.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 19.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

extension UserDefaults {
	subscript<T>(key: String) -> T? {
		get { return value(forKey: key) as? T }
		set { set(newValue, forKey: key) }
	}

	subscript<T: RawRepresentable>(key: String) -> T? {
		get {
			guard let rawValue = value(forKey: key) as? T.RawValue else {
				return nil
			}

			return T(rawValue: rawValue)
		}

		set {
			set(newValue?.rawValue, forKey: key)
		}
	}
}
