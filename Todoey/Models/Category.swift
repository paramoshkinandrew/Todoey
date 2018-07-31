//
//  Category.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 05/07/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = UIColor.randomFlat.hexValue()
    let items = List<Item>()
}
