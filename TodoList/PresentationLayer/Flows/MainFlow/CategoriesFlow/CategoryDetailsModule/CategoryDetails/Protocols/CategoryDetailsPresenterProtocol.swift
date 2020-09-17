//
//  CategoryDetailsPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol CategoryDetailsPresenterProtocol: class {
	var view: CategoryDetailsViewProtocol! { get }

	func saveButtonPressed(with viewModel: CategoryViewModel)
	func updateIcon(_ imagePath: String)
}
