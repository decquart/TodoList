//
//  GIDProfileData+User.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 03.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import GoogleSignIn

extension GIDProfileData: MappingOutput {

	var data: Data? {
		return try? Data(contentsOf: imageURL(withDimension: 240))
	}

	var mapToModel: User {
		return User(name: name,
					email: email,
					image: data)
	}
}
