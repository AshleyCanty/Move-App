//
//  PersistenceManager.swift
//  MoveApp
//
//  Created by ashley canty on 8/12/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import Foundation
import CoreData

final class PersistentManager {
    
    private init() {}
    static let shared = PersistentManager()
    
    // MARK: - Core Data stack

        lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "MoveApp")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    // MARK: - define
    
    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("error")
            return [T]()
        }
    }
}
