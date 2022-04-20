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
    
    func saveCar(brand: String, model: String, brand_pic: String, model_pic: String) {
        
        let car = Car(context: persistenContainer.viewContext)
        car.brand = brand
        car.model = model
        car.brand_pic = brand_pic
        car.model_pic = model_pic
        
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
    
    func getAllRents() -> [Rent] {
        
        let fetchRequest: NSFetchRequest<Rent> = Rent.fetchRequest()
        do {
            return try persistenContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveRent(car_brand: String, car_model: String, date_start: Date, date_end: Date, days: Int) {

        let rent = Rent(context: persistenContainer.viewContext)
        rent.car_brand = car_brand
        rent.car_model = car_model
        rent.date_start = date_start
        rent.date_end = date_end
        rent.days = Int16(days)

        do {
            try persistenContainer.viewContext.save()
        } catch {
            print("Failed to save rent \(error)")
        }
    }

    func deleteRent(rent: Rent) {
        persistenContainer.viewContext.delete(rent)

        do {
            try persistenContainer.viewContext.save()
        } catch {
            persistenContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    
}
