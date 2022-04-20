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
    
    
    var body: some View {
        VStack {
           if(rents == []) { Text("No rents here!")} else {
            List {
                ForEach(rents, id: \.self) { rent in
                    Text(rent.car_brand!)
                    Text(rent.car_model!)
                    Text(dateFormatter.string(from: rent.date_end!))
                }.padding()
            }.listStyle(PlainListStyle())
            //.background(Color.white)
            //Spacer()
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
