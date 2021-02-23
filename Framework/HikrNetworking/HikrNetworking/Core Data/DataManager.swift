//
//  CoreDataManager.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 19/02/2021.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    
    func save()
    func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) -> [NSFetchRequestResult]?
    @discardableResult func delete(_ request: NSBatchDeleteRequest) -> NSPersistentStoreResult?
    
    func createEntity(name: String) -> NSManagedObject
    
}

class DataManager: DataManagerProtocol {
    
    #warning("Move data model to framework")
    private var container: NSPersistentContainer
    
    init() {
        Logger.storage.log("Core data store initialized.", osLogType: .debug)
        
        self.container = NSPersistentContainer(name: "Hikr")
        guard let databaseUrl = getDatabaseUrl() else {
            preconditionFailure("Database url is broken!")
        }
        let description = NSPersistentStoreDescription(url: databaseUrl)
        description.type = NSSQLiteStoreType
        container.persistentStoreDescriptions = [description]
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { _, error in
            if let error = error {
                let errorMessage = "Can't run the app without core data! \(error.localizedDescription)"
                Logger.storage.log(errorMessage, osLogType: .error)
                preconditionFailure(errorMessage)
            } else {
                Logger.storage.log("Storage loaded successfully!", osLogType: .debug)
            }
        }
    }
    
    private func getDatabaseUrl() -> URL? {
        let fileName = "Hikr.sqlite"
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent(fileName)
    }
    
    func save() {
        guard container.viewContext.hasChanges else {
            return
        }
        do {
            try container.viewContext.save()
        } catch {
            let errorMessage = "Saving changes to core data has failed!"
            Logger.storage.log(errorMessage, osLogType: .error)
            assertionFailure(errorMessage)
        }
    }
    
    @objc(fetch:)
    func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) -> [NSFetchRequestResult]? {
        try? container.viewContext.fetch(request)
    }
    
    @objc(delete:)
    func delete(_ request: NSBatchDeleteRequest) -> NSPersistentStoreResult? {
        try? container.viewContext.execute(request)
    }
    
    func createEntity(name: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: name, into: container.viewContext)
    }
    
}
