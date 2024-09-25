//
//  reminder_page.swift
//  MoGu
//
//  Created by MacBook Air on 16/09/24.
//

import SwiftUI
import SwiftData

struct ReminderView: View {
    
//    @ObservedObject var serviceViewModel: SeviceViewModel
//    @StateObject var vehicleViewModel: VehicleViewModel
    @Query var serviceModel: [ServiceModel]
    @Query var vehicleModel: [VehicleModel]
    
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
                    
//                    List(services){service in
//                        VStack(alignment: .leading){
////                            Text("**Warning: \(service.service) change** should be scheduled soon. **Current kilometers: \(service.kilometer)**")
////                                .padding(10)
////                                .background(Color(hex: "#F5EFD4"))
//                            
//                            
//                            Text("**Warning: \(service.service) change** should be scheduled soon. **Current kilometers: \(service.kilometer)**")
//                                .font(.body)
//                            .frame(width: 310)
//                            .padding(10)
//                            .background(Color(hex: "#F5EFD4"))
//                            .cornerRadius(10)
//                        }
//                        .listRowSeparator(.hidden)
//                        
//                    }
//                    .listStyle(PlainListStyle())
                    
                    ForEach(serviceModel, id: \.self) { service in
                        switch service.serviceType {
                            case "Oil":
                                let kilometerkendaraan =  Int(vehicleModel.first?.kilometers ?? "") ?? 0
                                if(kilometerkendaraan >= 2500 && kilometerkendaraan <= 5000){
                                    Text("Warning: \(service.serviceType) change should be scheduled soon. Current kilometers:  \(vehicleModel.first?.kilometers ?? "")")
                                    .font(.body)
                                    .frame(width: 310, height: 90)
                                    .padding(10)
                                    .background(Color(hex: "#F5EFD4"))
                                    .cornerRadius(10)
                                }
                                else if(kilometerkendaraan >= 5000){
                                    Text("Urgent: \(service.serviceType) change should be scheduled soon. Current kilometers:  \(vehicleModel.first?.kilometers ?? "")")
                                    .font(.body)
                                    .bold()
                                    .frame(width: 310, height: 90)
                                    .padding(10)
                                    .background(Color(hex: "#F5D4D4"))
                                    .cornerRadius(10)
                                }
                            case "Tire":
                                let kilometerkendaraan =  Int(vehicleModel.first?.kilometers ?? "") ?? 0
                                if(kilometerkendaraan >= 10000 && kilometerkendaraan <= 15000){
                                    Text("Warning: \(service.serviceType) change should be scheduled soon. Current kilometers:  \(vehicleModel.first?.kilometers ?? "")")
                                    .font(.body)
                                    .padding(10)
                                    .frame(width: 310, height: 90)
                                    .padding(10)
                                    .background(Color(hex: "#F5EFD4"))
                                    .cornerRadius(10)
                                }
                                else if(kilometerkendaraan >= 15000){
                                    Text("Urgent: \(service.serviceType) change should be scheduled soon. Current kilometers:  \(vehicleModel.first?.kilometers ?? "")")
                                    .font(.body)
                                    .bold()
                                    .frame(width: 310, height: 90)
                                    .padding(10)
                                    .background(Color(hex: "#F5D4D4"))
                                    .cornerRadius(10)
                                }
                            case "Brake":
                                let kilometerkendaraan =  Int(vehicleModel.first?.kilometers ?? "") ?? 0
                                if(kilometerkendaraan >= 10000 && kilometerkendaraan <= 15000){
                                    Text("Warning: \(service.serviceType) change should be scheduled soon. Current kilometers:  \(vehicleModel.first?.kilometers ?? "")")
                                    .font(.body)
                                    .frame(width: 310, height: 90)
                                    .padding(10)
                                    .background(Color(hex: "#F5EFD4"))
                                    .cornerRadius(10)
                                }
                                else if(kilometerkendaraan >= 15000){
                                    Text("Urgent: \(service.serviceType) change should be scheduled soon. Current kilometers:  \(vehicleModel.first?.kilometers ?? "")")
                                    .font(.body)
                                    .bold()
                                    .frame(width: 310, height: 90)
                                    .padding(10)
                                    .background(Color(hex: "#F5D4D4"))
                                    .cornerRadius(10)
                                }
                            default:
                            ReminderView()
                        }
                    }
                    
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
//    var serviceC: Service
    
//    var backgroundColor: Color
//    var service: String
//    var textRemind:String
//    var kilometer: Int
//    @StateObject var vehicleViewModel: VehicleViewModel
    @Query var serviceModel: [ServiceModel]
    @Query var vehicleModel: [VehicleModel]
    
    
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
        
        ForEach(serviceModel, id: \.self) { service in
            switch service.serviceType {
                case "Oil":
                    let kilometerminim =  Int(service.kilometersMin) ?? 0
                    let kilometermaxi =  Int(service.kilometersMin) ?? 0
                    if(kilometerminim >= 2500 && kilometermaxi <= 5000){
                        HStack{
                            Text("**Warning: \(service.serviceType) change** should be scheduled soon. **Current kilometers: \(vehicleModel.first?.kilometers)**")
                                .font(.body)
                        }
                        .frame(width: 310)
                        .padding(10)
                        .background(Color(hex: "#F5EFD4"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    else if(kilometermaxi >= 5000){
                        HStack{
                            Text("**Urgent: \(service.serviceType) change** should be scheduled soon. **Current kilometers: \(vehicleModel.first?.kilometers)**")
                                .font(.body)
                        }
                        .frame(width: 310)
                        .padding(13)
                        .background(Color(hex: "#F5D4D4"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                case "Tire":
                    let kilometerminim =  Int(service.kilometersMin) ?? 0
                    let kilometermaxi =  Int(service.kilometersMin) ?? 0
                    if(kilometerminim >= 10000 && kilometermaxi <= 15000){
                        HStack{
                            Text("**Warning: \(service.serviceType) change** should be scheduled soon. **Current kilometers: \(vehicleModel.first?.kilometers)**")
                                .font(.body)
                        }
                        .frame(width: 310)
                        .padding(10)
                        .background(Color(hex: "#F5EFD4"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    else if(kilometermaxi >= 15000){
                        HStack{
                            Text("**Urgent: \(service.serviceType) change** should be scheduled soon. **Current kilometers: \(vehicleModel.first?.kilometers)**")
                                .font(.body)
                        }
                        .frame(width: 310)
                        .padding(13)
                        .background(Color(hex: "#F5D4D4"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                case "Brake":
                    let kilometerminim =  Int(service.kilometersMin) ?? 0
                    let kilometermaxi =  Int(service.kilometersMin) ?? 0
                    if(kilometerminim >= 10000 && kilometermaxi <= 15000){
                        HStack{
                            Text("**Warning: \(service.serviceType) change** should be scheduled soon. **Current kilometers: \(vehicleModel.first?.kilometers)**")
                                .font(.body)
                        }
                        .frame(width: 310)
                        .padding(10)
                        .background(Color(hex: "#F5EFD4"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    else if(kilometermaxi >= 15000){
                        HStack{
                            Text("**Urgent: \(service.serviceType) change** should be scheduled soon. **Current kilometers: \(vehicleModel.first?.kilometers)**")
                                .font(.body)
                        }
                        .frame(width: 310)
                        .padding(13)
                        .background(Color(hex: "#F5D4D4"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                default:
                ReminderView()
            }
        }
        
//        if(serviceC.service.elementsEqual("oil") && serviceC.kilometer >= 2500 && serviceC.kilometer <= 5000){
//            HStack{
//                Text("**Warning: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
//                    .font(.body)
//            }
//            .frame(width: 310)
//            .padding(10)
//            .background(Color(hex: "#F5EFD4"))
//            .foregroundColor(.black)
//            .cornerRadius(10)
//        }
//        else if(serviceC.service.elementsEqual("oil") && serviceC.kilometer > 5000){
//            HStack{
//                Text("**Urgent: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
//                    .font(.body)
//            }
//            .frame(width: 310)
//            .padding(13)
//            .background(Color(hex: "#F5D4D4"))
//            .foregroundColor(.black)
//            .cornerRadius(10)
//        }
//        
//        if(serviceC.service.elementsEqual("tire") && serviceC.kilometer >= 10000 && serviceC.kilometer <= 15000){
//            HStack{
//                Text("**Warning: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
//                    .font(.body)
//            }
//            .frame(width: 310)
//            .padding(10)
//            .background(Color(hex: "#F5EFD4"))
//            .foregroundColor(.black)
//            .cornerRadius(10)
//        }
//        else if(serviceC.service.elementsEqual("tire") && serviceC.kilometer > 15000){
//            HStack{
//                Text("**Urgent: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
//                    .font(.body)
//            }
//            .frame(width: 310)
//            .padding(13)
//            .background(Color(hex: "#F5D4D4"))
//            .foregroundColor(.black)
//            .cornerRadius(10)
//        }
//        
//        if(serviceC.service.elementsEqual("brake") && serviceC.kilometer >= 10000 && serviceC.kilometer <= 15000){
//            HStack{
//                Text("**Warning: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
//                    .font(.body)
//            }
//            .frame(width: 310)
//            .padding(10)
//            .background(Color(hex: "#F5EFD4"))
//            .foregroundColor(.black)
//            .cornerRadius(10)
//        }
//        else if(serviceC.service.elementsEqual("brake") && serviceC.kilometer > 15000){
//            HStack{
//                Text("**Urgent: \(serviceC.service) change** should be scheduled soon. **Current kilometers: \(serviceC.kilometer)**")
//                    .font(.body)
//            }
//            .frame(width: 310)
//            .padding(13)
//            .background(Color(hex: "#F5D4D4"))
//            .foregroundColor(.black)
//            .cornerRadius(10)
//        }
        
    }
}

#Preview {
    ReminderView()
}
