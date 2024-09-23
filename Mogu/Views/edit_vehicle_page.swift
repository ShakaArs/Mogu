//
//  edit_vehicle_page.swift
//  MoGu
//
//  Created by MacBook Air on 23/09/24.
//

import SwiftUI
import SwiftData

struct EditVehiclePage: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var km: String = ""
    @State private var dailyUse: String = ""
    @State private var weeklyUse: String = ""
    @ObservedObject var vehicleViewModel: VehicleViewModel
    var onComplete: () -> Void
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @Query var vehicleModel: [VehicleModel]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("VEHICLE TYPE")) {
                    Text(vehicleModel.first?.motorcycleType ?? "")
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("VEHICLE KILOMETERS")) {
                    TextField("Kilometers", text: $km)
                        .keyboardType(.numberPad)
                    TextField("Daily Use", text: $dailyUse)
                        .keyboardType(.numberPad)
                    TextField("Weekly Use", text: $weeklyUse)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: {
                        validateInputs()
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Edit Vehicle")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Message"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")) {
                          if alertMessage == "Vehicle data updated successfully!" {
                              dismiss()
                          }
                      })
            }
            .onAppear {
                if let vehicle = vehicleModel.first {
                    vehicleViewModel.loadVehicleData(from: vehicle)
                    km = vehicleViewModel.kilometers
                    dailyUse = vehicleViewModel.dailyUse
                    weeklyUse = vehicleViewModel.weeklyUse
                }
            }
        }
    }
    
    private func loadVehicleData() {
        if let vehicle = vehicleModel.first {
            km = vehicle.kilometers
            dailyUse = vehicle.dailyUse
            weeklyUse = vehicle.weeklyUse
        }
    }
    
    private func validateInputs() {
        if km.isEmpty || dailyUse.isEmpty || weeklyUse.isEmpty {
            alertMessage = "Please fill in all fields."
        } else if Int(km) == nil || Int(dailyUse) == nil || Int(weeklyUse) == nil {
            alertMessage = "Kilometers and usage must be valid numbers."
        } else {
            updateVehicle()
            alertMessage = "Vehicle data updated successfully!"
            onComplete()
        }
        showAlert = true
    }
    
    private func updateVehicle() {
        if let vehicle = vehicleModel.first {
            vehicleViewModel.kilometers = km
            vehicleViewModel.dailyUse = dailyUse
            vehicleViewModel.weeklyUse = weeklyUse
            vehicleViewModel.updateInput(vehicle: vehicle, modelContext: modelContext)
        }
    }
}

struct EditVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        EditVehiclePage(
            vehicleViewModel: VehicleViewModel()
        ) {
            // Completion action
        }
    }
}
//#Preview {
//    EditVehiclePage()
//}

