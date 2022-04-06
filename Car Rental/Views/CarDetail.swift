//
//  CarDetail.swift
//  Car Rental
//
//  Created by karol on 05/04/2022.
//

import SwiftUI

struct CarDetail: View {
    
    let car: Car
    @State private var carBrand: String = ""
    @State private var carModel: String = ""
    @State private var carPicName: String = ""
    
    let coreDM: CoreDataManager
    
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(car.brand ?? "", text: $carBrand)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField(car.model ?? "", text: $carModel)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField(car.pic_name ?? "", text: $carPicName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            Button(action: {
                if !carBrand.isEmpty && !carModel.isEmpty && !carPicName.isEmpty {
                    car.brand = carBrand
                    car.model = carModel
                    car.pic_name = carPicName
                    coreDM.updateCar()
                    needsRefresh.toggle()
                }
            }, label: {
                Text("Update".uppercased())
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .font(.headline)
                    .padding(.horizontal)
            })
            
        }
    }
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        let car = Car()
        let coreDM = CoreDataManager()
        CarDetail(car: car, coreDM: CoreDataManager(), needsRefresh: .constant(false))
    }
}
