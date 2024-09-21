//
//  MoGuApp.swift
//  MoGu
//
//  Created by MacBook Air on 13/09/24.
//

import SwiftUI
import SwiftData

@main
struct MoGuApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .modelContainer(for: VehicleModel.self)
//            ReminderView()
        }
        
    }
}
