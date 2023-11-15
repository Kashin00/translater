//
//  DataBaseManager.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import CoreData
import UIKit

protocol ManagedObjectConvertible {
  associatedtype ManagedObjectType: PersistenceEntityType
  func copyPropertiesTo(_ object: ManagedObjectType)
  init(dbEntity: ManagedObjectType)
}

protocol PersistenceEntityType: NSManagedObject {
  static var entityName: String { get }
}

protocol DataBaseManagerInput: AnyObject {
    
    @discardableResult
    func addEntities<E: ManagedObjectConvertible>(_ entities: [E]) -> [E.ManagedObjectType]
    
    func fetchObjectsOf<T: PersistenceEntityType>(_ type: T.Type, predicate: NSPredicate?) -> [T]
    
    func removeObjects<T: PersistenceEntityType>(_ objects: [T])
}

class DataBaseManager: TranslationHandler, DataBaseManagerInput {
    var nextHandler: TranslationHandler?
    
    func handle(request: TranslationModel) -> String? {
        //        if inBD {
        
        //        } else {
        return nextHandler?.handle(request: request)
        //        }
    }
    
    
    
    private var context: NSManagedObjectContext!
    
    //    private static var managedObjectContext: NSManagedObjectContext {
    //        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //    }
    
    @discardableResult
    func addEntities<E: ManagedObjectConvertible>(_ entities: [E]) -> [E.ManagedObjectType] {
        var objects: [E.ManagedObjectType] = []
        for entity in entities {
            guard
                let description = NSEntityDescription.entity(
                    forEntityName: E.ManagedObjectType.entityName,
                    in: context) else {
                return []
            }
            let object = E.ManagedObjectType(entity: description, insertInto: context)
            entity.copyPropertiesTo(object)
            objects.append(object)
        }
        print("ONJECTS: ", objects.count)
        return objects
    }

    func fetchObjectsOf<T>(_ type: T.Type, predicate: NSPredicate?) -> [T] where T: PersistenceEntityType {
      let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
      
      if let predicate = predicate {
        fetchRequest.predicate = predicate
      }
      
      var objects: [T] = []
      do {
        objects = try context.fetch(fetchRequest)
      } catch {
//        postErrorNotification(
//          .persistentStorageError(reason: .fetchFailed(message: error.localizedDescription))
//        )
      }
      return objects
    }
    
    func removeObjects<T>(_ objects: [T]) where T: PersistenceEntityType {
      objects.forEach { (entity) in
        context.delete(entity)
      }
    }
}
