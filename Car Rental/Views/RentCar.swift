//
//  RentCar.swift
//  Car Rental
//
//  Created by karol on 20/04/2022.
//

import SwiftUI

struct RentCar: View {
    let car: Car
    @State private var carBrand: String = ""
    @State private var carModel: String = ""
    @State private var start_date: Date = Date()
    @State private var date_end: Date = Date()
    @State private var days: Int = 0
    @State private var showingAlert = false
    
    let coreDM: CoreDataManager	
    
    private func canSave() -> Bool {
        if(carBrand.isEmpty || carModel.isEmpty){
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack {
            Form{
                TextField(car.brand ?? "", text: $carBrand)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                TextField(car.model ?? "", text: $carModel)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                DatePicker("Start Date", selection: $start_date)
                TextField("Rent days", value: $days, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }.onAppear {
                carBrand = car.brand ?? ""
                carModel = car.model ?? ""
            }
            Button(action: {
                if(!carBrand.isEmpty && !carModel.isEmpty){
                    car.brand = carBrand
                    car.model = carModel
                    var end = start_date
                    let seconds = days * 3600
                    end = end.addingTimeInterval(TimeInterval(seconds))
                    coreDM.saveRent(car_brand: carBrand, car_model: carModel, date_start: start_date, date_end: date_end, days: days)
                    showingAlert = true
                }
            }, label: {
                Text("Rent".uppercased())
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .font(.headline)
                    .padding(.horizontal)
            }).disabled(!canSave())
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Rent saved!"),
                    dismissButton: .default(Text("OK"))
                )
            }
            
        }
    }
}

struct RentCar_Previews: PreviewProvider {
    static var previews: some View {
        let car = Car()
        let coreDM = CoreDataManager()
        RentCar(car: car, coreDM: CoreDataManager())
    }
}
