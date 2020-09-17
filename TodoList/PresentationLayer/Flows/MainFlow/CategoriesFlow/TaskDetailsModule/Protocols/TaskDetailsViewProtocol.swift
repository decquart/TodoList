//
//  TaskDetailsViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol TaskDetailsViewProtocol: class {
	var presenter: TaskDetailsPresenterProtocol! { get }

	var isNewTask: Bool { get }
	func invalidateView()
}
