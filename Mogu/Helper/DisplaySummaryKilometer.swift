//
//  DisplaySummaryKilometer.swift
//  MoGu
//
//  Created by MacBook Air on 18/09/24.
//

import SwiftUI
import SwiftData

struct DisplaySummaryKilometer: View{
    @Query var vehicleModel : [VehicleModel]
//    @ObservedObject var vehicleViewModel: VehicleViewModel
    @State private var showEditPage = false
    @StateObject private var vehicleViewModel = VehicleViewModel()
        var body: some View {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(vehicleModel.first?.motorcycleType ?? "")
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                            .font(.title2)
                        
                        Text("Motorcycle")
                            .font(.title2)
                        Spacer()
                        Button(action: {
                            showEditPage = true
                        }) {
                            Text("Edit")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        }
                        .padding(.leading)
                                        
//                        NavigationLink(destination: ReminderView()) {
//                            Text("Edit")
//                                .foregroundColor(.black)
//                                .fontWeight(.bold)
//                            }
//                            .padding(.leading)
//                        NavigationLink(destination: EditVehiclePage(vehicleViewModel: vehicleViewModel) {
//                                                // Completion action
//                                            }, isActive: $showEditPage) {
//                                                Text("Edit")
//                                                    .foregroundColor(.black)
//                                                    .fontWeight(.bold)
//                                            }
//                                            .padding(.leading)
                    }

                        HStack {
                            Text(vehicleModel.first?.kilometers ?? "")
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
                .navigationDestination(isPresented: $showEditPage) {
                    EditVehiclePage(vehicleViewModel: vehicleViewModel) {
                                    // Completion action
                    showEditPage = false
                    }
                            }
            }
            }
}

#Preview {
    DisplaySummaryKilometer()
}
