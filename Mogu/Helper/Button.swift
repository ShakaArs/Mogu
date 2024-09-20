
//
//  Button.swift
//  MoGu
//
//  Created by MacBook Air on 16/09/24.
//

import SwiftUI

struct btnComponent<Destination: View>: View {
    var icon: String?
    var iconInput: String
    var buttonText: String
    var backgroundColor: Color
    var textColor: Color
    var frameHeight: CGFloat
    var textSize:CGFloat
    var destination:Destination

    
    var body: some View {
        NavigationLink(destination: destination) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
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
        .padding(.horizontal,20)
        .padding(.vertical,3)
    }
}
