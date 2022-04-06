//
//  ContentView.swift
//  Car Rental
//
//  Created by karol on 05/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    
    @State private var carBrand: String = ""
    @State private var carModel: String = ""
    @State private var carPicName: String = ""
    
    @State private var cars: [Car] = [Car]()
    @State private var needsRefresh: Bool = false
    
    private func populateCars() {
        cars = coreDM.getAllCars()
    }
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter brand", text: $carBrand)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                TextField("Enter model", text: $carModel)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                TextField("Enter pic name", text: $carPicName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Button(action: {
                    coreDM.saveCar(brand: carBrand, model: carModel, pic_name: carPicName)
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
                })
                
                List {
                    
                    ForEach(cars, id: \.self) { car in
                        NavigationLink(
                            destination: CarDetail(car: car, coreDM: coreDM, needsRefresh: $needsRefresh),
                            label: {
                                Text(car.model ?? "")
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
                
                Spacer()
            }.padding()
            .navigationTitle("Cars")
            
            .onAppear(perform: {
                cars = coreDM.getAllCars()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
