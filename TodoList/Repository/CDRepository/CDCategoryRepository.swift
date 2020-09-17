//
//  CDCategoryRepository.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

final class CDCategoryRepository: CDRepository<CategoryMO, Category> {
	override func fetch(where predicate: NSPredicate?, completion: @escaping (Result<[Category], Error>) -> Void) {
		let fetchRequest: NSFetchRequest<CategoryMO> = CategoryMO.fetchRequest()
		fetchRequest.predicate = predicate

		let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
			let data = result.finalResult?.map { $0.mapToModel } ?? []
			completion(.success(data))
		}

		do {
			try coreDataStack.mainContext.execute(asyncFetchRequest)
		} catch let error {
			completion(.failure(error))
		}
	}

	override func add(_ item: Category, completion: @escaping (Bool) -> Void) {
		let categoryMO = CategoryMO(context: coreDataStack.mainContext)

		categoryMO.map(item)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	override func update(_ item: Category, completion: @escaping (Bool) -> Void) {
		guard let existingCategory = get(by: item.id) else {
			return
		}

		existingCategory.map(item)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	override func delete(_ item: Category, completion: @escaping (Bool) -> Void) {
		guard let categoryMO = get(by: item.id) else {
			return
		}

		coreDataStack.mainContext.delete(categoryMO)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	private func get(by id: String) -> CategoryMO? {
		let predicate = NSPredicate(format: "id = %@", id)
		let fetchRequest: NSFetchRequest<CategoryMO> = CategoryMO.fetchRequest()
		fetchRequest.predicate = predicate

		return try? coreDataStack.mainContext.fetch(fetchRequest).first
	}
}

