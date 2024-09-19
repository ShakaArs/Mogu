import SwiftUI

struct InputVehiclePage: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedType = "Choose your vehicle"
    @State private var km: String = ""
    @State private var dailyUse: String = ""
    @State private var weeklyUse: String = ""
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
                        TextField("Your Current Kilometers", text: $km)
                            .onChange(of: km, { oldValue, newValue in
                                if newValue == "0" {
                                    km = ""
                                } else if newValue.hasPrefix("0") {
                                    km = String(newValue.dropFirst(1))
                                }
                            })
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Daily Use")
                        Spacer()
                        TextField("Your Estimated Daily Km", text: $dailyUse)
                            .onChange(of: dailyUse, { oldValue, newValue in
                                if newValue == "0" {
                                    dailyUse = ""
                                } else if newValue.hasPrefix("0") {
                                    dailyUse = String(newValue.dropFirst(1))
                                }
                            })
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Weekly Use")
                        Spacer()
                        TextField("Your Estimated Weekly Km", text: $weeklyUse)
                            .onChange(of: weeklyUse, { oldValue, newValue in
                                if newValue == "0" {
                                    weeklyUse = ""
                                } else if newValue.hasPrefix("0") {
                                    weeklyUse = String(newValue.dropFirst(1))
                                }
                            })
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
