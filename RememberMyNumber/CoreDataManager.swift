//
//  Persistence.swift
//  RememberMyNumber
//
//  Created by Antony Wilson on 6/12/22.
//

import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "RememberMyNumber")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data store failed to initialize \(error.localizedDescription)")
            }
        }
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(dirPaths[0])
    }
    
    func getAllContacts() -> [PhoneContact] {
        
        let fetchRequest: NSFetchRequest<PhoneContact> = PhoneContact.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func updateContact() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
    
    func deleteContact(contact: PhoneContact) {
        persistentContainer.viewContext.delete(contact)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
    
    func saveContact(name: String, number: String) {
        
        let contact = PhoneContact(context: persistentContainer.viewContext)
    
        contact.name = name
        contact.number = number
        
        do {
            try persistentContainer.viewContext.save()
            print("Contact Saved Successfully")
        } catch {
            print("Failed to save contact \(error)")
        }
    }
    
}
