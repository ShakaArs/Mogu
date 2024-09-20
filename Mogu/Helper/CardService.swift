//
//  CardService.swift
//  MoGu
//
//  Created by MacBook Air on 19/09/24.
//

import SwiftUI

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
                RoundedRectangle(cornerRadius: 7)
                    .fill(backgroundColor)
                    .frame(height: frameHeight)
                    .shadow(radius: 10)
                HStack {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: 30, weight: .medium))
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
                DatePickerView(serviceType: serviceType, selectedDate: $selectedDate, viewModel: ServiceViewModel())
                    
            }
                
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
    }
}
struct DatePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    var serviceType: String
    @Binding var selectedDate: Date
    @ObservedObject var viewModel: ServiceViewModel
    
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
                
                Button("Done") {
                    viewModel.updateServiceDate(for: serviceType, with: selectedDate)
                    print("Saved date for \(serviceType): \(selectedDate)")
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(.green)
                .font(.headline)
            }
        }
    }
}
