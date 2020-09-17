//
//  CDUserRepository.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 27.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

final class CDUserRepository: CDRepository<UserMO, User> {

	override func fetch(where predicate: NSPredicate?, completion: @escaping (Result<[User], Error>) -> Void) {
		let fetchRequest: NSFetchRequest<UserMO> = UserMO.fetchRequest()
		fetchRequest.predicate = predicate

		do {
			let users = try coreDataStack.mainContext.fetch(fetchRequest)
			completion(.success(users.map { $0.mapToModel }))
		} catch {
			completion(.failure(error))
		}
	}

	override func add(_ item: User, completion: @escaping (Bool) -> Void) {
		let userMO = UserMO(context: coreDataStack.mainContext)

		userMO.map(item)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	override func update(_ item: User, completion: @escaping (Bool) -> Void) {
		guard let existingUser = get(by: item.name) else {
			completion(false)
			return
		}

		existingUser.map(item)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	func get(by userName: String) -> UserMO? {
		let predicate = NSPredicate(format: "name = %@", userName)
		let fetchRequest: NSFetchRequest<UserMO> = UserMO.fetchRequest()
		fetchRequest.predicate = predicate

		return try? coreDataStack.mainContext.fetch(fetchRequest).first
	}
}
