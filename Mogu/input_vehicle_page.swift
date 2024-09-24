import SwiftUI

struct InputVehiclePage: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var selectedType: String = "Choose your vehicle"
    @State private var km: String = ""
    @State private var dailyUse: String = ""
    @State private var weeklyUse: String = ""
    @StateObject var vehicleViewModel: VehicleViewModel
    var onComplete: () -> Void
    @State private var errorMessage: String?
    let vehicleTypes = ["Manual", "Matic", "Sport"]
    @State private var successMessage: String?
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @State private var navigateToSummary = false
    @State private var showSuccessAlert = false
    
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
                        validateInputs()
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("PrimaryColor"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .listRowInsets(EdgeInsets())
                }
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Input Vehicle")
            .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertMessage),
                                  message: Text(alertMessage ?? "Unknown error"),
                                  dismissButton: .default(Text("OK")) {
                                      if alertMessage == "Vehicle data submitted successfully!" {
                                          dismiss()
                                      }
                                  })
                        }
        
            
        }
    }
    private func validateInputs() {
            alertMessage = ""
               
               if km.isEmpty || dailyUse.isEmpty || weeklyUse.isEmpty || selectedType == "Choose your vehicle" {
                   alertMessage = "Please fill in all fields."
               } else if Int(km) == nil || Int(dailyUse) == nil || Int(weeklyUse) == nil {
                   alertMessage = "Kilometers and usage must be valid numbers."
               } else {
                   vehicleViewModel.motorcycleType = selectedType
                   vehicleViewModel.kilometers = km
                   vehicleViewModel.dailyUse = dailyUse
                   vehicleViewModel.weeklyUse = weeklyUse
                   vehicleViewModel.createVehicle(modelContext: modelContext)
                   alertMessage = "Vehicle data submitted successfully!"
                   onComplete()
               }
               
               if alertMessage != "" {
                   showAlert = true
               }
           }
        

}



struct InputVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        InputVehiclePage(
            vehicleViewModel: VehicleViewModel()
        ) {
            // Completion action
        }
    }
}
