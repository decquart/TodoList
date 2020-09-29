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
	let onEditIndex = PublishSubject<Int>()

	var onShowCategoryDetails: ScopeCategoryHandler?
	var onPresent: TaskHandler?

	let disposeBag = DisposeBag()

	private var categories: [Category] = [] {
		didSet {
			categoryModels.onNext(categories.map {
				return CategoryViewModel(model: $0)
			})
		}
	}

	init(categoryRepository: AnyRepository<Category>, taskRepository: AnyRepository<Task>) {
		self.categoryRepository = categoryRepository
		self.taskRepository = taskRepository

		Observable.zip(onEditIndex, categoryModels)
			.map { index, models in
				return models[index]
			}
			.subscribe(onNext: { [weak self] in
				self?.onShowCategoryDetails?(.edit(model: $0))
			})
			.disposed(by: disposeBag)

		onSelectIndexPath
			.subscribe(onNext: { [weak self] in
				guard let category = self?.categories[$0.row] else { return }
				self?.onPresent?(category)
			})
			.disposed(by: disposeBag)
	}

	func loadCategories() {
		categoryRepository.fetch(where: nil) { [weak self] result in
			switch result {
			case .success(let categories):
				self?.categories = categories
			case .failure(_):
				break
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
