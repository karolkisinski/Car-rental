//
//  CarDetail.swift
//  Car Rental
//
//  Created by karol on 05/04/2022.
//

import SwiftUI

struct CarEdit: View {
    
    let car: Car
    @State private var carBrand: String = ""
    @State private var carModel: String = ""
    @State private var carBrandPic: String = ""
    @State private var carModelPic: String = ""
    @State private var showingAlert = false
    @State var brandSelect = "Toyota"
    @State var modelSelect = "Supra"
    var brands = ["Toyota", "Ford", "Nissan"]
    var models = ["Silvia", "Bronco", "Ranger", "Skyline", "Carina", "Supra"]
    
    let coreDM: CoreDataManager
    
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            Form{
                TextField(car.brand ?? "", text: $carBrand)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                TextField(car.model ?? "", text: $carModel)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Picker("Brand", selection: $brandSelect, content: {
                    ForEach(brands, id: \.self, content: { brand in
                        Text(brand)
                    })
                })
                Picker("Model", selection: $modelSelect, content: {
                    ForEach(models, id: \.self, content: { model in
                        Text(model)
                    })
                })
            }.onAppear {
                carBrand = car.brand ?? ""
                carModel = car.model ?? ""
            }
            Button(action: {
                    car.brand = carBrand
                    car.model = carModel
                    car.brand_pic = brandSelect
                    car.model_pic = modelSelect
                    coreDM.updateCar()
                    needsRefresh.toggle()
                    showingAlert = true
            }, label: {
                Text("Update".uppercased())
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .font(.headline)
                    .padding(.horizontal)
            }).alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Car updated!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct CarEdit_Previews: PreviewProvider {
    static var previews: some View {
        let car = Car()
        CarEdit(car: car, coreDM: CoreDataManager(), needsRefresh: .constant(false))
    }
}
