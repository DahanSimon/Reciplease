//
//  TestCoreData.swift
//  RecipleaseTests
//
//  Created by Simon Dahan on 14/06/2021.
//

import CoreData
import Reciplease

class TestCoreDataStack: CoreDataStack {
  override init() {
    super.init()

    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType

    let container = NSPersistentContainer(
      name: CoreDataStack.modelName,
      managedObjectModel: CoreDataStack.model)

    container.persistentStoreDescriptions = [persistentStoreDescription]

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    storeContainer = container
  }
}
