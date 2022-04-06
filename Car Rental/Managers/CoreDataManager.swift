//
//  CoreDataManager.swift
//  Car Rental
//
//  Created by karol on 05/04/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistenContainer: NSPersistentContainer
    
    init() {
        persistenContainer = NSPersistentContainer(name: "CoreDataModel")
        persistenContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func getAllCars() -> [Car] {
        
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        do {
            return try persistenContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveCar(brand: String, model: String, pic_name: String) {
        
        let car = Car(context: persistenContainer.viewContext)
        car.brand = brand
        car.model = model
        car.pic_name = pic_name
        
        do {
            try persistenContainer.viewContext.save()
        } catch {
            print("Failed to save car \(error)")
        }
    }
    
    func deleteCar(car: Car) {
        persistenContainer.viewContext.delete(car)
        
        do {
            try persistenContainer.viewContext.save()
        } catch {
            persistenContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateCar() {
        
        do {
            try persistenContainer.viewContext.save()
            print("updated")
        } catch {
            persistenContainer.viewContext.rollback()
        }
    }
    
    
}
