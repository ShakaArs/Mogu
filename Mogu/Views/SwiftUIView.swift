
//  SwiftUIView.swift
//  MoGu
//
//  Created by MacBook Air on 18/09/24.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        SplashScreenView()
    }
}

#Preview {
    SwiftUIView()
}


struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 2.0
    var body: some View {
        Group {
            if isActive {
                SummaryView(vehicleViewModel: VehicleViewModel())
            } else {
                VStack {
                    
                    Image("logo")
                        .resizable()
                        .frame(width:310,height: 300)
                         
                    
                }
                .opacity(opacity)
                .onAppear {
  
                    withAnimation(.easeOut(duration: 3.0)) {
                        opacity = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
