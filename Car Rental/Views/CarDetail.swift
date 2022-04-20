//
//  CarDetail.swift
//  Car Rental
//
//  Created by karol on 05/04/2022.
//

import SwiftUI

struct CarDetail: View {
    
    let car: Car
    
    let coreDM: CoreDataManager
    @State var scaleImg: CGFloat = 1.0
    var body: some View {
        VStack {
            Text(car.brand! + " " + car.model!).font(.largeTitle)
            Image("\(car.model_pic!)")
                .resizable()
                .frame(width: 200, height: 200)
                .scaleEffect(scaleImg)
                .gesture(TapGesture()
                            .onEnded(){_ in scaleImg += 1
                                if (scaleImg>2.1) {scaleImg = 1}
                            })
        }
        NavigationView{
            VStack{
                NavigationLink(
                    destination: RentCar(car: car, coreDM: coreDM),
                    label: {
                        Text("Rent car")
                    }).font(.title2)
                }
        
            }
    }
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        let car = Car()
        let coreDM = CoreDataManager()
        CarDetail(car: car, coreDM: CoreDataManager())
    }
}
