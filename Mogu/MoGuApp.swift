import SwiftUI
import SwiftData
import UserNotifications

@main
final class MoGuApp: NSObject, App, UNUserNotificationCenterDelegate {
    
    // Required initializer
    override init() {
        super.init() // Call the superclass initializer
        UNUserNotificationCenter.current().delegate = self
        
        // Schedule notification for today at 00:17 (adjust as needed)
        scheduleNotificationForToday()
    }
    
    // Schedule a notification for today at 00:17 (or other time)
    func scheduleNotificationForToday() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // Create the target date for today at 00:17
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        dateComponents.hour = 0
        dateComponents.minute = 25
        
        if let triggerDate = calendar.date(from: dateComponents) {
            scheduleNotification(for: "Oil", currentKilometers: 5000, triggerDate: triggerDate)
        }
    }
    
    // Function to schedule a notification
    func scheduleNotification(for service: String, currentKilometers: Int, triggerDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Warning: \(service) change"
        content.body = "The \(service) change should be scheduled soon. Current kilometers: \(currentKilometers)"
        
        // Directly assign the custom sound "brom_brom.caf"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("brom_brom.caf"))

        // Set up the trigger date components
        let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        
        // Create the notification request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for \(triggerDate)")
            }
        }
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
        }
    }
}
