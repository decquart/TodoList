//
//  Constants.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

typealias ScopeCategoryHandler = (Scope<CategoryViewModel>) -> Void
typealias TaskHandler = (Category) -> Void
typealias TaskDetailsHandler = ((Category, Scope<TaskViewModel>) -> Void)
