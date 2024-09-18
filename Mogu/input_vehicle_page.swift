import SwiftUI

struct InputVehiclePage: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedType = "Choose your vehicle"
    @State private var km: Int? = nil
    @State private var dailyUse: Int? = nil
    @State private var weeklyUse: Int? = nil
    @ObservedObject var vehicleViewModel: VehicleViewModel
    var onComplete: () -> Void
    
    let vehicleTypes = ["Manual", "Matic", "Sport"]
    
    @State private var showAlert = false
    @State private var navigateToSummary = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("VEHICLE TYPES")) {
                    Picker("Vehicle Type", selection: $selectedType) {
                        Text("Choose your vehicle").tag("Choose your vehicle")
                        ForEach(vehicleTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("VEHICLE KILOMETERS")) {
                    HStack {
                        Text("Kilometers")
                        Spacer()
                        TextField("Your Current Kilometers", value: $km, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Daily Use")
                        Spacer()
                        TextField("Your Estimated Daily Km", value: $dailyUse, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Weekly Use")
                        Spacer()
                        TextField("Your Estimated Weekly Km", value: $weeklyUse, formatter: NumberFormatter())
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section {
                    Button(action: {
                        vehicleViewModel.createVehicle(motorcycleType: selectedType, kilometers: km, dailyUse: dailyUse, weeklyUse: weeklyUse)
                        showAlert = true
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
            .navigationTitle("Input Vehicle")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Submit Success"),
                    message: Text("Your data has been submitted successfully."),
                    dismissButton: .default(Text("OK")) {
                        onComplete()
                        dismiss()
                    }
                )
            }
        }
    }
}

struct InputVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        InputVehiclePage(vehicleViewModel: VehicleViewModel()) {
            // Completion action
        }
    }
}
