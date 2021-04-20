//
//  DatabaseProvider.swift
//  PixaGame
//
//  Created by Didik on 20/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import CoreData

class DatabaseProvider {
    
    static let shared = DatabaseProvider()
    static let databaseName = "GameDataModel"
    static let favoriteEntityName = "Favorite"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: DatabaseProvider.databaseName)
        
        container.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return taskContext
    }
}
