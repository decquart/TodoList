//
//  Scope.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 28.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum Scope<Model> {
	case create
	case edit(model: Model)

	var model: Model? {
		switch self {
		case .edit(let model):
			return model
		default:
			return nil
		}
	}
}
