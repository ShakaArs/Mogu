import SwiftUI

struct InputVehiclePage: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedType = "Choose your vehicle"
    @State private var km : Int? = nil
    @State private var dailyUse: Int? = nil
    @State private var weeklyUse: Int? = nil
    
    let vehicleTypes = ["Manual", "Matic", "Sport"]
    
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
                        print("Submit tapped")
                        print("Kilometers: \(String(describing: km))")
                        print("Daily Use: \(String(describing: dailyUse))")
                        print("Weekly Use: \(String(describing: weeklyUse))")
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .listRowInsets(EdgeInsets())
                }            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Input Vehicle")
        }
    }
}

struct InputVehiclePage_Previews: PreviewProvider {
    static var previews: some View {
        InputVehiclePage()
    }
}
