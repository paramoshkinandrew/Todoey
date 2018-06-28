//
//  TodoElement.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 25/06/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import Foundation

class Item: Codable {
    var title: String = ""
    var done: Bool = false
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
