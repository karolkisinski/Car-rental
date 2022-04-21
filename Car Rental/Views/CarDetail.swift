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
    @State private var showingAlert = false
    
    let coreDM: CoreDataManager
    @State var scaleImg: CGFloat = 1.0
    var body: some View {
        VStack {
            Text(car.brand! + " " + car.model!).font(.largeTitle)
            Image("\(car.brand_pic!)")
                .resizable()
                .frame(width: 100, height: 100)
            Image("\(car.model_pic!)")
                .resizable()
                .frame(width: 200, height: 200)
                .scaleEffect(scaleImg)
                .gesture(TapGesture()
                            .onEnded(){_ in scaleImg += 1
                                if (scaleImg>2.1) {scaleImg = 1}
                            })
            Spacer()
        }
        Button(action: {
            carBrand = car.brand!
            carModel = car.model!
            coreDM.saveRent(car_brand: carBrand, car_model: carModel)
            showingAlert = true
        }, label: {
            Text("Rent".uppercased())
                .foregroundColor(.white)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(10)
                .font(.headline)
                .padding(.horizontal)
        }).alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Car rented!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        let car = Car()
        CarDetail(car: car, coreDM: CoreDataManager())
    }
}
