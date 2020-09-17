//
//  CategoryListViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol CategoryListViewProtocol: class {
	var presenter: CategoryListPresenterProtocol! { get }

	func reload()
}
