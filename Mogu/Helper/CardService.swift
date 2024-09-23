//
//  CardService.swift
//  MoGu
//
//  Created by MacBook Air on 19/09/24.
//

import SwiftUI
import SwiftData

struct CardService: View {
    var icon: String?
    var iconInput: String
    var buttonText: String
    var backgroundColor: Color
    var textColor: Color
    var frameHeight: CGFloat
    var textSize: CGFloat
    var serviceType: String
    @State private var showAlert = false
    var vehicleViewModel: Bool=false
    
    @State private var showingDatePicker = false
    @State private var selectedDate = Date()
    
    var body: some View {
        Button(action: {
            if vehicleViewModel{
                showAlert=false
                showingDatePicker.toggle()
            } else {
                showAlert = true
            }
            
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(backgroundColor)
                    .frame(height: frameHeight)
                    .shadow(radius: 10)
                HStack {
//                    if let icon = icon {
//                        Image(systemName: icon)
//                            .font(.system(size: 30, weight: .medium))
//                    }
                    VStack{
                        if let icon = icon {
                            Image(systemName: icon)
                                .font(.system(size: 30, weight: .medium))
                        }
                        Spacer().frame(height: 10)
                        Text(serviceType)
                            .font(.system(size: 15 * 0.9))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                        Text(buttonText)
                            .font(.system(size: textSize, weight: .medium))
                            .padding(10)
                            Spacer()
                            Image(systemName: iconInput)
                                .font(.system(size: 30, weight: .medium))
                        }
                        .foregroundColor(textColor)
                        .padding()
                    }
                }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Belum"),
                message: Text("Data kendaraan belum diatur."),
                dismissButton: .default(Text("OK"))
            )
    }
                .sheet(isPresented: $showingDatePicker) {
                    DatePickerView(serviceType: serviceType, selectedDate: $selectedDate, viewModelService: ServiceViewModel(), viewModelVehicle: VehicleViewModel())
                    
            }
                
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
    }
}
struct DatePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    var serviceType: String
    @Binding var selectedDate: Date
    @ObservedObject var viewModelService: ServiceViewModel
    @ObservedObject var viewModelVehicle: VehicleViewModel
    @Query var vehicleModel: [VehicleModel]
    
    var body: some View {
        VStack {
            Text("Set your latest \(serviceType) change")
                .font(.title)
                .padding()
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding()
            
            HStack{
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(.red)
                .font(.headline)
                
                Spacer()
                
                Button(action: {
                    print("Button pressed")
                    
                    guard let kilometersString = vehicleModel.first?.kilometers,
                          let kilometers = Int(kilometersString) else {
                        print("Invalid kilometers")
                        return
                    }
                    
                    // Update service details
                    viewModelService.updateServiceDate(for: serviceType, with: selectedDate)
                    viewModelService.serviceType = serviceType
                    viewModelService.lastDateService = selectedDate
                    
                    // Calculate kilometers
                    let minKilometers = kilometers + 2500
                    let maxKilometers = kilometers + 5000
                    viewModelService.kilometersMin = String(minKilometers)
                    viewModelService.kilometersMax = String(maxKilometers)
                    
                    viewModelService.maxDateService = Calendar.current.date(byAdding: .day, value: -30, to: selectedDate) ?? selectedDate
                    
                    
                    viewModelService.createService(modelContext: modelContext)
                    print(viewModelService.kilometersMax, viewModelService.kilometersMin)
                    dismiss()

                    // Dismiss the view
//                    DispatchQueue.main.async {
//                        dismiss()
//                    }
                }) {
                    Text("Done")
                }
                .padding()
                .foregroundColor(.green)
                .font(.headline)

            }
        }
    }
}
