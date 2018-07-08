//
//  AppDelegate.swift
//  Todoey
//
//  Created by Andrew Paramoshkin on 02/06/2018.
//  Copyright © 2018 Andrew Paramoshkin. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("Realm file: \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        do {
            let _ = try Realm.init()
        } catch {
            print("Error on Realm initialization: \(error)")
        }
        
        return true
    }
}

