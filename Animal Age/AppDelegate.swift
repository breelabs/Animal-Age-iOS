//
//  AppDelegate.swift
//  Animal Age Converter
//
//  Created by Jon Brown on 2/15/14.
//  Copyright (c) 2014 Jon Brown. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    @objc private var _persistentContainer: NSPersistentContainer?
    @objc var persistentContainer: NSPersistentContainer? {
        // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if _persistentContainer == nil {
                _persistentContainer = NSPersistentContainer(name: "Model")
                _persistentContainer?.loadPersistentStores(completionHandler: { storeDescription, error in
                    if error != nil {
                        if let error = error, let userInfo = (error as NSError?)?.userInfo {
                            print("Unresolved error \(error), \(userInfo)")
                        }
                        abort()
                    }
                })
            }
        }

        return _persistentContainer
    }

    
    func saveContext() {
        let context = persistentContainer?.viewContext
        if context!.hasChanges {
            do {
                try context?.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }

}

