//
//  ContentView.swift
//  Car Rental
//
//  Created by karol on 05/04/2022.
//

import SwiftUI
import Combine

struct AddCar: View {
    
    
    let coreDM: CoreDataManager
    
    @State private var carBrand: String = ""
    @State private var carModel: String = ""
    @State private var carBrandPic: String = ""
    @State private var carModelPic: String = ""
    @State var brandSelect = "Toyota"
    @State var modelSelect = "Supra"
    var brands = ["Toyota", "Ford", "Nissan"]
    var models = ["Silvia", "Bronco", "Ranger", "Skyline", "Carina", "Supra"]
    @State private var cars: [Car] = [Car]()
    @State private var needsRefresh: Bool = false
    
    private func populateCars() {
        cars = coreDM.getAllCars()
    }
    private func canSave() -> Bool {
        if(carBrand.isEmpty || carModel.isEmpty){
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    TextField("Enter brand", text: $carBrand)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    TextField("Enter model", text: $carModel)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
//                    TextField("Enter pic name", text: $carBrandPic)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal)
//                    TextField("Enter pic name", text: $carModelPic)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.horizontal)
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
                    Button(action: {
                        coreDM.saveCar(brand: carBrand, model: carModel, brand_pic: brandSelect, model_pic: modelSelect)
                        populateCars()
                    }, label: {
                        Text("save".uppercased())
                            .foregroundColor(.white)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .font(.headline)
                            .padding(.horizontal)
                    }).disabled(!canSave())
                }.background(Color.white)
                List {
                    ForEach(cars, id: \.self) { car in
                        NavigationLink(
                            destination: CarEdit(car: car, coreDM: coreDM, needsRefresh: $needsRefresh),
                            label: {
                                Text(car.brand! + " " + car.model! )
                            })
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let car = cars[index]
                            //delete using CDM
                            coreDM.deleteCar(car: car)
                            populateCars()
                        }
                    })
                }.listStyle(PlainListStyle())
                .accentColor(needsRefresh ? .white: .black)
                .background(Color.white)
                Spacer()
            }.padding()
            .navigationTitle("Cars")
            
            .onAppear(perform: {
                cars = coreDM.getAllCars()
            })
        }
    }
}

struct AddCar_Previews: PreviewProvider {
    static var previews: some View {
        AddCar(coreDM: CoreDataManager())
    }
}
