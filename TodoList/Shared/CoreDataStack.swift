//
//  CoreDataStack.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 05.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStackType {
	var mainContext: NSManagedObjectContext { get }
	var backgroundContext: NSManagedObjectContext { get }
	func save(context: NSManagedObjectContext)
}

final class CoreDataStack: CoreDataStackType {
	private let modelName: String

	init(modelName: String) {
		self.modelName = modelName
	}

	private lazy var storeContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: self.modelName)

		container.loadPersistentStores { (storeDescription, error) in
			if let error = error as NSError? {
				print("Unresolved error \(error), \(error.userInfo)")
			}
		}

		return container
	}()

	lazy var mainContext: NSManagedObjectContext = {
		return self.storeContainer.viewContext
	}()

	lazy var backgroundContext: NSManagedObjectContext = {
		return self.storeContainer.newBackgroundContext()
	}()

	func save(context: NSManagedObjectContext) {
		guard context.hasChanges else { return }

		do {
			try context.save()
		} catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
		}
	}
}

