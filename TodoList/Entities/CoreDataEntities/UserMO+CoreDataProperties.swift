//
//  UserMO+CoreDataProperties.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 27.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserMO")
    }

    @NSManaged public var email: String
    @NSManaged public var name: String
	@NSManaged public var image: Data?

}

// MARK: - Mappable
extension UserMO: Mappable {
	var mapToModel: User {
		return User(name: name, email: email, image: image)
	}

	func map(_ entity: User) {
		self.name = entity.name
		self.email = entity.email
		self.image = entity.image
	}
}
