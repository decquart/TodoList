//
//  CoreDataStackHolder.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

//TODO: remove
class CoreDataStackHolder {
	static let shared = CoreDataStackHolder()
	lazy var coreDataStack: CoreDataStack = CoreDataStack(modelName: "TodoList")
}
