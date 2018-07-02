//
//  TodoElement.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 25/06/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import Foundation
import CoreData

class Item: NSManagedObject {
    
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
    }
}
