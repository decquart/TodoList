//
//  RealmRepository.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RealmSwift

class RealmRepository<Obj, Model>: AnyRepository<Model> where Obj: Object {
	let realm = try! Realm()
}
