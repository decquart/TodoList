//
//  Repository.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol Repository {
	associatedtype Item

	func fetch(where predicate: NSPredicate?, completion: @escaping (Result<[Item], Error>) -> Void)
	func add(_ item: Item, completion: @escaping (Bool) -> Void)
	func update(_ item: Item, completion: @escaping (Bool) -> Void)
	func delete(_ item: Item, completion: @escaping (Bool) -> Void)
}

class AnyRepository<Item>: Repository {
	func fetch(where predicate: NSPredicate?, completion: @escaping (Result<[Item], Error>) -> Void) {
		fatalError("")
	}

	func add(_ item: Item, completion: @escaping (Bool) -> Void) {
		fatalError("")
	}

	func update(_ item: Item, completion: @escaping (Bool) -> Void) {
		fatalError("")
	}

	func delete(_ item: Item, completion: @escaping (Bool) -> Void) {
		fatalError("")
	}
}

extension AnyRepository {

	typealias FunctionHandler = (Item, @escaping (Bool) -> Void) -> Void

	func add(_ items: [Item], completion: @escaping (Bool) -> Void) {
		execute(function: add, items: items, completion: completion)
	}

	func update(_ items: [Item], completion: @escaping (Bool) -> Void) {
		execute(function: update, items: items, completion: completion)
	}

	func delete(_ items: [Item], completion: @escaping (Bool) -> Void) {
		execute(function: delete, items: items, completion: completion)
	}

	private func execute(function: @escaping FunctionHandler, items: [Item], completion: @escaping (Bool) -> Void) {
		let itemGroup = DispatchGroup()
		var failedItems: [Item] = []

		for item in items {
			DispatchQueue.main.async(group: itemGroup) {
				function(item) { success in
					failedItems.append(item)
				}
			}
		}

		itemGroup.notify(queue: .main) {
			completion(!failedItems.isEmpty)
		}
	}
}
