//
//  reminder_page.swift
//  MoGu
//
//  Created by MacBook Air on 16/09/24.
//

import SwiftUI

struct ReminderView: View {
    
//    @ObservedObject var serviceViewModel: SeviceViewModel
    
    let services = [
        Service(service: "oil", kilometer: 5500),
        Service(service: "oil", kilometer: 3000),
        Service(service: "oil", kilometer: 2500),
        Service(service: "tire", kilometer: 15500),
        Service(service: "tire", kilometer: 13000),
        Service(service: "tire", kilometer: 10500),
        Service(service: "brake", kilometer: 16000),
        Service(service: "brake", kilometer: 12000),
        Service(service: "brake", kilometer: 10500),
    ]
    
    var body: some View {
        TabView{
            NavigationView {
                VStack{

//                    ViewRemindWarning(
//                        backgroundColor: Color(hex: "#F5EFD4"),
//                        service: "tire",
//                        textRemind: serviceViewModel.checkTireService(currentKilometers: 20000)
//                    )
                    
                    List(services){service in
                        VStack(alignment: .leading){
                            ViewRemindWarning(serviceC: service)
                        }
                        .listRowSeparator(.hidden)
                        
                    }
                    .listStyle(PlainListStyle())
//
//                    ViewRemind(
//                        backgroundColor: Color(hex: "#F5D4D4"),
//                        textReminder: "brake change by 14-10-2024"
//                    )
//                    
//                    ViewRemind(
//                        backgroundColor: Color(hex: "#F5EFD4"),
//                        textReminder: "tire change by 13-01-2025"
//                    )
//                    
                    Spacer()
                }
                .navigationTitle("Reminder")
            }.padding()
            
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let rgbValue = UInt32(hex, radix: 16)
        let r = Double((rgbValue! & 0xFF0000) >> 16) / 255
        let g = Double((rgbValue! & 0x00FF00) >> 8) / 255
        let b = Double(rgbValue! & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

struct Service: Identifiable{
    let id = UUID()
//    let date: String
    let service: String
    let kilometer: Int
}

struct ViewRemindWarning: View {
    var serviceC: Service
    
//    var backgroundColor: Color
//    var service: String
//    var textRemind:String
//    var kilometer: Int
    
    var body: some View {
        
//            HStack{
//                Text(textRemind)
//                    .font(.body)
//            }
//            .frame(width: 310)
//            .padding(10)
//            .background(backgroundColor)
//            .foregroundColor(.black)
//            .cornerRadius(10)
        if(serviceC.service.elementsEqual("oil") && serviceC.kilometer >= 2500 && serviceC.kilometer <= 5000){
            HStack{
                Text("**Warning: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
                    .font(.body)
            }
            .frame(width: 310)
            .padding(10)
            .background(Color(hex: "#F5EFD4"))
            .foregroundColor(.black)
            .cornerRadius(10)
        }
        else if(serviceC.service.elementsEqual("oil") && serviceC.kilometer > 5000){
            HStack{
                Text("**Urgent: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
                    .font(.body)
            }
            .frame(width: 310)
            .padding(13)
            .background(Color(hex: "#F5D4D4"))
            .foregroundColor(.black)
            .cornerRadius(10)
        }
        
        if(serviceC.service.elementsEqual("tire") && serviceC.kilometer >= 10000 && serviceC.kilometer <= 15000){
            HStack{
                Text("**Warning: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
                    .font(.body)
            }
            .frame(width: 310)
            .padding(10)
            .background(Color(hex: "#F5EFD4"))
            .foregroundColor(.black)
            .cornerRadius(10)
        }
        else if(serviceC.service.elementsEqual("tire") && serviceC.kilometer > 15000){
            HStack{
                Text("**Urgent: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
                    .font(.body)
            }
            .frame(width: 310)
            .padding(13)
            .background(Color(hex: "#F5D4D4"))
            .foregroundColor(.black)
            .cornerRadius(10)
        }
        
        if(serviceC.service.elementsEqual("brake") && serviceC.kilometer >= 10000 && serviceC.kilometer <= 15000){
            HStack{
                Text("**Warning: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
                    .font(.body)
            }
            .frame(width: 310)
            .padding(10)
            .background(Color(hex: "#F5EFD4"))
            .foregroundColor(.black)
            .cornerRadius(10)
        }
        else if(serviceC.service.elementsEqual("brake") && serviceC.kilometer > 15000){
            HStack{
                Text("**Urgent: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
                    .font(.body)
            }
            .frame(width: 310)
            .padding(13)
            .background(Color(hex: "#F5D4D4"))
            .foregroundColor(.black)
            .cornerRadius(10)
        }
        
    }
}

#Preview {
    ReminderView()
}
