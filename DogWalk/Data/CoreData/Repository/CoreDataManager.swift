//
//  DataContainer.swift
//  DogWalk
//
//  Created by 김윤우 on 11/11/24.
//

import CoreData

final class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        ChatMessagesTransformer.register()
        let container = NSPersistentContainer(name: "Chat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
