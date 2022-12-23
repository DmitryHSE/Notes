//
//  CoreDataManager.swift
//  Notes
//
//  Created by Dmitry on 23.12.2022.
//

import UIKit
import CoreData

final class DataManager {
    
    enum constants: String {
        case entityName = "Note"
        case header = "header"
        case textBody = "textBody"
    }
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?
    var entityDescription: NSEntityDescription?
    var managedObject: NSManagedObject?
    
    func readSavedData() -> [DataModel] {
        context = appDelegate.persistentContainer.viewContext
        entityDescription = NSEntityDescription.entity(forEntityName: constants.entityName.rawValue, in: context!)
        var array = [DataModel]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: constants.entityName.rawValue)
        do {
            guard let results = try context?.fetch(fetchRequest) else {return []}
            for i in results as! [NSManagedObject] {
                let header = i.value(forKey: constants.header.rawValue) as! String
                let textBody = i.value(forKey: constants.textBody.rawValue) as! String
                array.append(DataModel(header: header, textBody: textBody))
            }
        } catch {
            print(error)
        }
        //print("Data read succesfully")
        return array
    }
    
    func saveData(h: String, t: String) {
        context = appDelegate.persistentContainer.viewContext
        entityDescription = NSEntityDescription.entity(forEntityName: constants.entityName.rawValue, in: context!)
        managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        managedObject?.setValue(h, forKey: constants.header.rawValue)
        managedObject?.setValue(t, forKey: constants.textBody.rawValue)
        appDelegate.saveContext()
        //print("Saved succesfully")
    }
    
    func deleteAllData() {
        context = appDelegate.persistentContainer.viewContext
        entityDescription = NSEntityDescription.entity(forEntityName: constants.entityName.rawValue, in: context!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: constants.entityName.rawValue)
        do {
            guard let results = try context?.fetch(fetchRequest) else {return}
            for i in results as! [NSManagedObject] {
                context?.delete(i)
            }
        } catch {
            print(error)
        }
        appDelegate.saveContext()
        //print("All deleted succesfully")
    }
    
}
