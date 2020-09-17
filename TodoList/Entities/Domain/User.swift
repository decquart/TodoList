//
//  User.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 27.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

struct User {
	let name: String
	let email: String
	var image: Data?

	init(name: String, email: String, image: Data? = nil) {
		self.name = name
		self.email = email
		self.image = image
	}
}
