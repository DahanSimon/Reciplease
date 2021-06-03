//
//  Recipe+CoreDataClass.swift
//  Reciplease
//
//  Created by Simon Dahan on 02/06/2021.
//
//

import Foundation
import CoreData


public class Recipe: NSManagedObject {
    
}

func resetAllRecords(in entity : String) // entity = Your_Entity_Name
{
    let context = AppDelegate.viewContext
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
    catch
    {
        print ("There was an error")
    }
}
