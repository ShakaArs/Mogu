import SwiftUI
import SwiftData
import UserNotifications

@main
final class MoGuApp: NSObject, App, UNUserNotificationCenterDelegate {
    
    @StateObject private var vehicleViewModel = VehicleViewModel() // Initialize the view model

    // Required initializer
    override init() {
        super.init() // Call the superclass initializer
        UNUserNotificationCenter.current().delegate = self
        
        // Schedule notifications when the app initializes
        scheduleDailyNotifications()
    }

    // Schedule daily notifications at specific times
    func scheduleDailyNotifications() {
        let times = [9, 12, 14] // Notification times (9 AM, 12 PM, 2 PM)
        
        for time in times {
            scheduleNotification(for: time)
        }
    }
    
    // Function to schedule a notification for a specific time
    func scheduleNotification(for hour: Int) {
        // Load the current kilometers from the vehicle view model
        let currentKilometers = Int(vehicleViewModel.kilometers) ?? 0
        
        let serviceWarnings = checkServiceConditions(currentKilometers: currentKilometers)
        
        for warning in serviceWarnings {
            let content = UNMutableNotificationContent()
            content.title = warning.title
            content.body = warning.message
            content.sound = UNNotificationSound(named: UNNotificationSoundName("brom_brom.caf"))

            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = 0 // Set to the start of the hour
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled for \(hour):00")
                }
            }
        }
    }

    // Function to check service conditions based on kilometers
    private func checkServiceConditions(currentKilometers: Int) -> [(title: String, message: String)] {
        var warnings: [(String, String)] = []
        
        // Oil service
        if currentKilometers >= 2500 && currentKilometers < 5000 {
            warnings.append(("Warning: Oil change", "Oil change should be scheduled soon. Current kilometers: \(currentKilometers)"))
        } else if currentKilometers >= 5000 {
            warnings.append(("Urgent: Oil change", "Oil change required! Current kilometers: \(currentKilometers)"))
        }

        // Tire and brake service
        if currentKilometers >= 10000 && currentKilometers < 15000 {
            warnings.append(("Warning: Tire and brake service", "Tire and brake service should be scheduled soon. Current kilometers: \(currentKilometers)"))
        } else if currentKilometers >= 15000 {
            warnings.append(("Urgent: Tire and brake service", "Tire and brake service required! Current kilometers: \(currentKilometers)"))
        }
        
        return warnings
    }
    
    // UNUserNotificationCenterDelegate method to handle notifications while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification banner even when the app is running
        completionHandler([.banner, .sound])
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .modelContainer(for: [VehicleModel.self, ServiceModel.self])
                .environmentObject(vehicleViewModel) // Pass the view model to the environment
        }
    }
}
