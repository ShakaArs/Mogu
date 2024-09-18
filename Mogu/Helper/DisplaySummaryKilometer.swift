//
//  DisplaySummaryKilometer.swift
//  MoGu
//
//  Created by MacBook Air on 18/09/24.
//

import SwiftUI

struct DisplaySummaryKilometer: View{
    var body: some View {
            VStack(alignment: .leading){
                HStack{
                    Text("Automatic")
                        .foregroundColor(.green)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title2)
                    
                    Text("Motorcycle")
                        .font(.title2)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Edit")
                            .foregroundColor(.black)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }).padding(.leading)
                }

                HStack{
                    Text("012670")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("km")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
}

#Preview {
    DisplaySummaryKilometer()
}
