//
//  DisplaySummaryKilometer.swift
//  MoGu
//
//  Created by MacBook Air on 18/09/24.
//

import SwiftUI
import SwiftData

struct DisplaySummaryKilometer: View {
    @Query var vehicleModel: [VehicleModel]
    @Environment(\.modelContext) private var modelContext
    @State private var showEditPage = false
    @StateObject private var vehicleViewModel = VehicleViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(vehicleModel.first?.motorcycleType ?? "")
                        .foregroundColor(Color("PrimaryColor"))
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
                }
                
                HStack {
                    // Menampilkan kilometer dari view model yang sudah diperbarui
                    Text(vehicleViewModel.kilometers)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("km")
                        .foregroundColor(Color("PrimaryColor"))
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .onAppear {
                // Panggil fungsi update saat tampilan muncul
                vehicleViewModel.loadVehicleData(from: vehicleModel.first ?? VehicleModel())
//                vehicleViewModel.updateKilometersWeekly(modelContext: modelContext)
                updateVehicle()
            }
            .navigationDestination(isPresented: $showEditPage) {
                EditVehiclePage(vehicleViewModel: vehicleViewModel) {
                    showEditPage = false
                }
            }
        }
    }
    private func updateVehicle() {
        if let vehicle = vehicleModel.first {
            // Perbarui data di ViewModel
            vehicleViewModel.kilometers = vehicleViewModel.updateKilometersWeekly()

            // Hitung kilometer baru berdasarkan logika penggunaan harian dan mingguan
            /*vehicleViewModel.updateKilometersWeekly(modelContext: modelContext)*/ // Pastikan fungsi ini memperbarui kilometer

            // Update data di model dan simpan perubahan
            vehicleViewModel.updateInput(vehicle: vehicle, modelContext: modelContext)
        }
    }
}

#Preview {
    DisplaySummaryKilometer()
}
