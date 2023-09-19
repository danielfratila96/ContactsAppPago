//
//  CoreDataManager.swift
//  ContactsApp
//
//  Created by Daniel Fratila on 9/16/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    private init() {} // Prevent clients from creating another instance.
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ContactsCoreData")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createData(contacts: [ContactCoreDataModel]) {
        let managedContext = persistentContainer.viewContext
        
        let contactsEntity = NSEntityDescription.entity(forEntityName: "Contacts", in: managedContext)!
        
        contacts.forEach { contact in
            let contactObject = NSManagedObject(entity: contactsEntity, insertInto: managedContext)
            
            contactObject.setValue(contact.id, forKeyPath: "id")
            contactObject.setValue(contact.firstName, forKeyPath: "firstName")
            contactObject.setValue(contact.lastName, forKeyPath: "lastName")
            contactObject.setValue(contact.phoneNO, forKeyPath: "phoneNO")
            contactObject.setValue(contact.email, forKeyPath: "email")
            contactObject.setValue(contact.gender, forKeyPath: "gender")
            contactObject.setValue(contact.status, forKey: "status")
        }
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() -> [ContactCoreDataModel] {
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        
        var contactCoreDataModels: [ContactCoreDataModel] = []
        do {
            let result = try managedContext.fetch(fetchRequest)
            for contactObject in result as! [NSManagedObject] {
                let contactCoreDataModel: ContactCoreDataModel = .init(id: contactObject.value(forKey: "id") as! Int,
                                                                       firstName: contactObject.value(forKey: "firstName") as! String,
                                                                       lastName: contactObject.value(forKey: "lastName") as! String,
                                                                       phoneNO: contactObject.value(forKey: "phoneNO") as! String,
                                                                       email: contactObject.value(forKey: "email") as! String,
                                                                       gender: contactObject.value(forKey: "gender") as! String,
                                                                       status: contactObject.value(forKey: "status") as! String)
                contactCoreDataModels.append(contactCoreDataModel)
            }
            
            return contactCoreDataModels
            
        } catch {
            print("Failed to fetch from Core Data")
            return []
        }
    }
    
    func updateData(contact: ContactCoreDataModel){
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Contacts")
        fetchRequest.predicate = NSPredicate(format: "email = %@", contact.email)
        do
        {
            let contactObjects = try managedContext.fetch(fetchRequest)
            
            var objectUpdate: NSManagedObject
            if contactObjects.count > 0 {
                objectUpdate = contactObjects[0] as! NSManagedObject
            } else {
                let contactsEntity = NSEntityDescription.entity(forEntityName: "Contacts", in: managedContext)!
                objectUpdate = NSManagedObject(entity: contactsEntity, insertInto: managedContext)
            }
            
            objectUpdate.setValue(contact.id, forKeyPath: "id")
            objectUpdate.setValue(contact.firstName, forKeyPath: "firstName")
            objectUpdate.setValue(contact.lastName, forKeyPath: "lastName")
            objectUpdate.setValue(contact.phoneNO, forKeyPath: "phoneNO")
            objectUpdate.setValue(contact.email, forKeyPath: "email")
            objectUpdate.setValue(contact.gender, forKeyPath: "gender")
            objectUpdate.setValue(contact.status, forKey: "status")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
}
