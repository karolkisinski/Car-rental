//
//  ContentView.swift
//  Car Rental
//
//  Created by karol on 05/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    
    @State private var isAdmin = false
    var body: some View {
        
        NavigationView {
            VStack {
                Toggle("Are you admin?", isOn: $isAdmin)
                if(isAdmin){
                NavigationLink(
                    destination: AddCar(coreDM: coreDM),
                    label: {
                        Text("Add cars")
                    }).font(.title2)
                }
                NavigationLink(
                    destination: ShowCars(coreDM: coreDM),
                    label: {
                        Text("Show cars")
                    }).font(.title2)
                NavigationLink(
                    destination: RentedCars(coreDM: coreDM),
                    label: {
                        Text("Rented cars")
                    }).font(.title2)
                Spacer()
            }.navigationTitle("Car rental")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
