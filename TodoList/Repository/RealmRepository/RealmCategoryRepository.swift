//
//  RealmCategoryRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmCategoryRepository: RealmRepository<CategoryObject, Category> {
	override func fetch(where predicate: NSPredicate?, completion: @escaping (Result<[Category], Error>) -> Void) {
		var objects = realm.objects(CategoryObject.self)

		if let predicate = predicate {
			objects = objects.filter(predicate)
		}

		let entities = Array(objects.compactMap { $0.mapToModel })
		completion(.success(entities))
	}

	override func add(_ item: Category, completion: @escaping (Bool) -> Void) {
		let categoryObj = CategoryObject()
		categoryObj.map(item)

		do {
			try realm.write { realm.add(categoryObj) }
			completion(true)
		} catch {
			print("Can not add: \(error.localizedDescription)")
			completion(false)
		}
	}

	override func update(_ item: Category, completion: @escaping (Bool) -> Void) {
		guard let existingCategoryObj = realm.object(ofType: CategoryObject.self, forPrimaryKey: item.id) else {
			completion(false)
			return
		}

		try! realm.write { existingCategoryObj.map(item) }
		completion(true)
	}

	override func delete(_ item: Category, completion: @escaping (Bool) -> Void) {
		guard let categoryToDelete = realm.object(ofType: CategoryObject.self, forPrimaryKey: item.id) else {
			return
		}

		do {
			try realm.write { realm.delete(categoryToDelete) }
			completion(true)
		} catch {
			print("Cannot delete: \(error.localizedDescription)")
			completion(false)
		}
	}
}
