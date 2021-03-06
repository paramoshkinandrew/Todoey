//
//  Item.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 05/07/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
