//
//  Mappable.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 07.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol MappingOutput {
	associatedtype Model

	var mapToModel: Model { get }
}

protocol MappingInput {
	associatedtype Model

	func map(_ model: Model)
}

typealias Mappable = MappingOutput & MappingInput
