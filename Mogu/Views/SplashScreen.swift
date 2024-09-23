//
//  SwiftUIView.swift
//  MoGu
//
//  Created by MacBook Air on 18/09/24.
//

import SwiftUI
import AVFoundation

struct SplashScreen: View {
    var body: some View {
        SplashScreenView()
    }
}

#Preview {
    SplashScreen()
}

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    @State private var scale: CGFloat = 0.6
    @State private var blurRadius: CGFloat = 10.0
    @State private var offsetX: CGFloat = 0.0
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        Group {
            if isActive {
                SummaryView(vehicleViewModel: VehicleViewModel(), serviceViewModel: ServiceViewModel())
            } else {
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 310, height: 300)
                        .scaleEffect(scale)
                        .blur(radius: blurRadius)
                        .opacity(opacity)
                        .offset(x: offsetX)
                }
                .onAppear {
                    playSound() // Play sound effect
                    // Initial zoom and blur effects
                    withAnimation(.easeInOut(duration: 4.5)) {
                        opacity = 1.0
                        scale = 1.1
                        blurRadius = 0.0
                    }

                    // Power zoom-in effect
                    withAnimation(.easeInOut(duration: 1.5).delay(2.9)) {
                        scale = 1.4
                    }

                    // Exit slide animation after 3 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        withAnimation(.easeInOut(duration: 1.8)) {
                            offsetX = UIScreen.main.bounds.width // Slide to the left
                        }
                        // Set isActive to true after the slide animation completes
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }

    // Function to play the sound effect
    func playSound() {
        if let soundURL = Bundle.main.url(forResource: "brom_brom", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}
