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
    
    func fetchObjectsOf<T: PersistenceEntityType>(_ type: T.Type,
                                                  predicate: NSPredicate?) throws ->  [T]
    
    func removeObjects<T: PersistenceEntityType>(_ objects: [T])
    func saveContext()
}

class DataBaseManager: DataBaseManagerInput {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TranslatorDB")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                //          let internalError =
                //            InternalError.persistentStorageError(reason: .failedToInitCoreDataStack(message: error.localizedDescription))
                //          postErrorNotification(internalError)
            } else {
                container.viewContext.mergePolicy = NSOverwriteMergePolicy
                //        container.viewContext.concurrencyType = .mainQueueConcurrencyType
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
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
    
    func fetchObjectsOf<T>(_ type: T.Type, predicate: NSPredicate?) throws -> [T] where T: PersistenceEntityType {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        var objects: [T] = []
        objects = try context.fetch(fetchRequest)
        return objects
    }
    
    func removeObjects<T>(_ objects: [T]) where T: PersistenceEntityType {
        objects.forEach { (entity) in
            context.delete(entity)
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save")
        }
    }
}
