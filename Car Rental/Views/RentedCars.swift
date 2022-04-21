//
//  RentedCars.swift
//  Car Rental
//
//  Created by karol on 20/04/2022.
//

import SwiftUI

struct RentedCars: View {
    
    @State private var rents: [Rent] = [Rent]()
    let coreDM: CoreDataManager
    let dateFormatter = DateFormatter()
    
    private func populateRents() {
        rents = coreDM.getAllRents()
    }
    var body: some View {
        VStack {
           if(rents == []) { Text("No rents here!")} else {
            List {
                ForEach(rents, id: \.self) { rent in
                    Text(rent.car_brand! + " " + rent.car_model!)
                }.onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let rent = rents[index]
                        //delete using CDM
                        coreDM.deleteRent(rent: rent)
                        populateRents()
                    }
                })
                .padding()
            }.listStyle(PlainListStyle())

            }
        }.padding()
        .navigationTitle("Rents")
        .onAppear(perform: {
            rents = coreDM.getAllRents()
        })
    }
}

struct RentedCars_Previews: PreviewProvider {
    static var previews: some View {
        RentedCars(coreDM: CoreDataManager())
    }
}
