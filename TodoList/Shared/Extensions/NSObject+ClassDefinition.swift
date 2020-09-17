//
//  NSObject+ClassDefinition.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 30.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

extension NSObject {
	static func nameOfClass() -> String {
		return NSStringFromClass(self).components(separatedBy: ".").last!
	}
}
