//
//  ShowCars.swift
//  Car Rental
//
//  Created by karol on 20/04/2022.
//


import SwiftUI
import Combine

struct ShowCars: View {
    
    let coreDM: CoreDataManager
    
    @State private var cars: [Car] = [Car]()
    
    private func populateCars() {
        cars = coreDM.getAllCars()
    }
    var body: some View {
        NavigationView {
                VStack {
                    if(cars == []) { Text("No cars here!")} else {
                    List {
                        ForEach(cars, id: \.self) { car in
                            NavigationLink(
                                destination: CarDetail(car: car, coreDM: coreDM),
                                label: {
                                    Text(car.brand! + " " + car.model! )
                                })
                        }
                    }.listStyle(PlainListStyle())
                    .background(Color.white)
                    Spacer()
                    }
                }.padding()
                .navigationTitle("Cars")
                
                .onAppear(perform: {
                    cars = coreDM.getAllCars()
                })}

        }
    }


struct ShowCars_Previews: PreviewProvider {
    static var previews: some View {
        ShowCars(coreDM: CoreDataManager())
    }
}
