//
//  reminder_page.swift
//  MoGu
//
//  Created by MacBook Air on 16/09/24.
//

import SwiftUI

struct ReminderView: View {
    var body: some View {
        TabView{
            NavigationView {
                VStack{

                    VStack{
                        VStack{
                            HStack{
                                Text("Motor Service Due : Your motorcycle needs a ")
                                    .font(.body)
                                Spacer()
                            }
                            HStack{
                                Text(" brake change by 14-10-2024").bold()
                                Spacer()
                            }
                        }
                    }
                    .padding(15)
                    .background(Color(hex: "#F5D4D4"))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                    HStack{
                        VStack{
                            HStack{
                                Text("Motor Service Due : Your motorcycle needs a ")
                                    .font(.body)
                                Spacer()
                            }
                            HStack{
                                Text(" brake change by 14-10-2024").bold()
                                Spacer()
                            }
                        }
                    }
                    .padding(15)
                    .background(Color(hex: "#F5D4D4"))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                    HStack{
                        VStack{
                            HStack{
                                Text(" Motor Service Due : Your motorcycle needs a ")
                                    .font(.body)
                                Spacer()
                            }
                            HStack{
                                Text(" tire change by 13-01-2025").bold()
                                Spacer()
                            }
                        }
                    }
                    .padding(15)
                    .background(Color(hex: "#F5EFD4"))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
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

#Preview {
    ReminderView()
}
