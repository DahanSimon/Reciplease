//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Simon Dahan on 14/06/2021.
//

import Foundation
import CoreData

open class CoreDataStack {
  public static let modelName = "Reciplease"

  public static let model: NSManagedObjectModel = {
    let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()
    
  public lazy var mainContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()

  public lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  public func saveContext() -> Bool {
    do {
      try mainContext.save()
        return true
    } catch _ as NSError {
        return false
    }
  }
}
