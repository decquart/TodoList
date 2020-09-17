//
//  CDTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

final class CDTaskRepository: CDRepository<TaskMO, Task> {
	let categoryId: String

	init(categoryId: String, coreDataStack: CoreDataStackType) {
		self.categoryId = categoryId
		super.init(coreDataStack: coreDataStack)
	}

	override func fetch(where predicate: NSPredicate?, completion: @escaping (Result<[Task], Error>) -> Void) {
		let fetchRequest: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
		fetchRequest.predicate = predicate
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(key: "completed", ascending: true),
			NSSortDescriptor(key: "date", ascending: true),
			NSSortDescriptor(key: "description_p", ascending: true)
		]

		let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
			let entities = result.finalResult?.map { $0.mapToModel } ?? []
			completion(.success(entities))
		}

		do {
			try coreDataStack.mainContext.execute(asyncFetchRequest)
		} catch {
			completion(.failure(error))
		}
	}

	override func add(_ item: Task, completion: @escaping (Bool) -> Void) {
		let categoryFetchRequest: NSFetchRequest<CategoryMO> = CategoryMO.fetchRequest()
		categoryFetchRequest.predicate = NSPredicate(format: "id = %@", categoryId)

		let taskName = String(describing: TaskMO.self)

		guard let taskMO = NSEntityDescription.insertNewObject(forEntityName: taskName, into: coreDataStack.mainContext) as? TaskMO else {
			return
		}

		guard let categoryMO = try? coreDataStack.mainContext.fetch(categoryFetchRequest).first else {
			return
		}

		taskMO.map(item)
		categoryMO.addToTasks(taskMO)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	override func update(_ item: Task, completion: @escaping (Bool) -> Void) {
		guard let storedTask = get(by: item.uuid) else {
			return
		}

		storedTask.map(item)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	private func get(by id: String) -> TaskMO? {
		let fetchRequest: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id = %@", id)

		return try? coreDataStack.mainContext.fetch(fetchRequest).first
	}
}
