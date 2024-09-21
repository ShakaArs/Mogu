//
//  DisplaySummaryKilometer.swift
//  MoGu
//
//  Created by MacBook Air on 18/09/24.
//

import SwiftUI

struct DisplaySummaryKilometer: View{
    
    @ObservedObject var vehicleViewModel: VehicleViewModel
    var body: some View {
        VStack(alignment: .leading) {
                    HStack {
                        Text(vehicleViewModel.motorcycleType)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .font(.title2)
                        
                        Text("Motorcycle")
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            // Add edit action here, if needed
                        }, label: {
                            Text("Edit")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }).padding(.leading)
                    }

                    HStack {
                        Text("\(vehicleViewModel.kilometers)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("km")
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                    }
            
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 5)
            }
}

#Preview {
    DisplaySummaryKilometer(vehicleViewModel: VehicleViewModel())
}
