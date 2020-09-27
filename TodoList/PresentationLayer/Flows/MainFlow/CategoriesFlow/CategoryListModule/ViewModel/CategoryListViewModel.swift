//
//  CategoryListViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RxSwift

final class CategoryListViewModel {

	private let categoryRepository: AnyRepository<Category>
	private let taskRepository: AnyRepository<Task>

	let categoryModels = PublishSubject<[CategoryViewModel]>()

	let onSelectIndexPath = PublishSubject<IndexPath>()
	let onSelectCategory = PublishSubject<Category>()

	let onEditIndex = PublishSubject<Int>()
	let onEditCategory = PublishSubject<Scope<CategoryViewModel>>()

	let disposeBag = DisposeBag()

	private var categories: [Category] = []
	private let groupedCategoriesWithTasks = BehaviorSubject<[Category: [Task]]>(value: [:])

	init(categoryRepository: AnyRepository<Category>, taskRepository: AnyRepository<Task>) {
		self.categoryRepository = categoryRepository
		self.taskRepository = taskRepository

		Observable.zip(onEditIndex, categoryModels)
			.map { index, models in
				return models[index]
			}
			.subscribe(onNext: { [weak self] in
				self?.onEditCategory.onNext(.edit(model: $0))
			})
			.disposed(by: disposeBag)

		onSelectIndexPath
			.subscribe(onNext: { [weak self] in
				guard let category = self?.categories[$0.row] else { return }
				self?.onSelectCategory.onNext(category)
			})
			.disposed(by: disposeBag)

		groupedCategoriesWithTasks
			.flatMap { tasks -> Observable<[CategoryViewModel]> in
				let categoryModels = tasks.map { category, tasks -> CategoryViewModel in
					let taskCount = tasks.count
					let completedTaskCount = tasks.filter { $0.completed }.count

					return CategoryViewModel(model: category,
											 taskCount: taskCount,
											 completedTaskCount: completedTaskCount)
				}

				return .just(categoryModels.sorted { $0.name.lowercased() < $1.name.lowercased() })
			}
			.subscribe(onNext: { [weak self] in
				self?.categoryModels.onNext($0)
			})
			.disposed(by: disposeBag)
	}

	func loadCategories() {
		categoryRepository.fetch(where: nil) { [weak self] result in
			switch result {
			case .success(let categories):
				self?.categories = categories.sorted { $0.name.lowercased() < $1.name.lowercased() }
				self?.fetchTasks(for: categories)
			case .failure(_):
				break
			}
		}
	}

	func fetchTasks(for categories: [Category]) {
		let ids = categories.map { $0.id }
		var groupedTasks: [Category: [Task]] = [:]

		let dispatchGroup = DispatchGroup()

		DispatchQueue.main.async(group: dispatchGroup) { [weak self] in
			for id in ids {
				let predicate = NSPredicate(format: "ANY owner.id == %@", id)
				dispatchGroup.enter()

				self?.taskRepository.fetch(where: predicate) { result in
					switch result {
					case .success(let task):
						let category = categories.first { $0.id == id }!
						groupedTasks[category] = task
					default:
						break
					}

					dispatchGroup.leave()
				}
			}

			dispatchGroup.notify(queue: .main) {
				self?.groupedCategoriesWithTasks.onNext(groupedTasks)
			}
		}
	}

	func removeItem(at index: Int) {
		let category = categories[index]

		categoryRepository.delete(category) { success in
			if success {
				self.categories = self.categories.filter { category.id != $0.id }
			}
		}
	}
	
	func editItem(at index: Int) {
		onEditIndex.onNext(index)
	}
}
