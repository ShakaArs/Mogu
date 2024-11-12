import Foundation
import SwiftData


class VehicleViewModel: ObservableObject {
    // Properties that you want to store
    @Published var motorcycleType: String = "Unknown"
    @Published var kilometers: String = ""
    @Published var dailyUse: String = ""
    @Published var weeklyUse: String = ""
    @Published var isVehicleDataSet: Bool = false
    private var lastUpdated: Date = Date()
    
    // Method to create a new vehicle entry
    func createVehicle(modelContext: ModelContext) {
        print(motorcycleType,kilometers,dailyUse,weeklyUse,isVehicleDataSet, lastUpdated)
        let newVehicle = VehicleModel(
            motorcycleType: motorcycleType,
            kilometers: kilometers,
            dailyUse: dailyUse,
            weeklyUse: weeklyUse,
            isVehicleDataSet: true,
            lastUpdated: Date()
        )
//        newVehicle.lastUpdated = Date()
        modelContext.insert(newVehicle)
        do{
            try modelContext.save()
            isVehicleDataSet = true
        } catch {
            print("Failed to save vehicle data: \(error.localizedDescription)")
            isVehicleDataSet = false
        }
        
    }
    
    func loadVehicleData(from vehicle: VehicleModel) {
            motorcycleType = vehicle.motorcycleType
            kilometers = vehicle.kilometers
            dailyUse = vehicle.dailyUse
            weeklyUse = vehicle.weeklyUse
            isVehicleDataSet = true
            lastUpdated = vehicle.lastUpdated
        }
    
    func updateInput(vehicle: VehicleModel, modelContext: ModelContext) {
            // Update the properties of the existing vehicle
//            vehicle.motorcycleType = motorcycleType
            vehicle.kilometers = kilometers
            vehicle.dailyUse = dailyUse
            vehicle.weeklyUse = weeklyUse
            vehicle.lastUpdated = Date()
            do {
                try modelContext.save()  // Save the updated vehicle
                print("Vehicle updated successfully")
                lastUpdated = vehicle.lastUpdated
                print("\(vehicle.motorcycleType) \(vehicle.kilometers) \(vehicle.dailyUse) \(vehicle.weeklyUse) \(vehicle.isVehicleDataSet)")
                isVehicleDataSet = true 
            } catch {
                print("Failed to update vehicle data: \(error.localizedDescription)")
            }
        }
    
    func updateKilometersWeekly() -> String {
        let currentDate = Date()
        let calendar = Calendar.current

        // Calculate the difference in weeks between the current date and the last updated date
            if let weeksElapsed = calendar.dateComponents([.weekOfYear], from: lastUpdated, to: currentDate).weekOfYear {
                
                if weeksElapsed > 0 {
                    // Calculate the total kilometers to add based on weeks passed
                    let dailyUsage = Int(dailyUse) ?? 0
                    let weeklyUsage = Int(weeklyUse) ?? 0
                    let additionalKilometers = weeklyUsage * dailyUsage * weeksElapsed

                    // Update the kilometers and the last updated time
                    let currentKilometers = Int(kilometers) ?? 0
                    let newKilometers = currentKilometers + additionalKilometers
                    self.kilometers = String(newKilometers)
                    
                    // Update lastUpdated to the new date
                    lastUpdated = currentDate
                    
                    // Check service conditions for maintenance
                    checkServiceConditions(currentKilometers: newKilometers)
                    
                    print("Kilometers updated by \(additionalKilometers) over \(weeksElapsed) week(s). New total: \(newKilometers)")
                    
//                    saveUpdatedKilometers(newKilometers, modelContext: modelContext)
                    // Return the new kilometers value as String
                    return self.kilometers
                } else {
                    print("No weeks have passed since the last update.")
                }
            }
            return self.kilometers  // Return the current kilometers if no update is made
        

    }
//    private func saveUpdatedKilometers(_ newKilometers: Int , modelContext: ModelContext) {
//        // Assuming you have a reference to your service model
//        let vehicle = VehicleModel(
//            motorcycleType: motorcycleType,
//            kilometers: String(newKilometers),
//            dailyUse: dailyUse,
//            weeklyUse: weeklyUse,
//            isVehicleDataSet: true,
//            lastUpdated: lastUpdated
//        )
//
//        // Save the changes to the context
//        do {
//            modelContext.insert(vehicle)
//            try modelContext.save()
//            print("Updated kilometers saved to vehicle model.")
//        } catch {
//            print("Failed to save updated kilometers: \(error.localizedDescription)")
//        }
//    }
    
    // Check if service is needed based on kilometers
    private func checkServiceConditions(currentKilometers: Int) -> (title: String, content: String)? {
        // Service messages
        var title: String?
        var content: String?

        // Oil service (lower limit: 2500, upper limit: 5000)
        if currentKilometers >= 2500 && currentKilometers < 5000 {
            title = "Warning: Oil change"
            content = "should be scheduled soon. Current kilometers: \(currentKilometers)"
        } else if currentKilometers >= 5000 {
            title = "Urgent: Oil change"
            content = "is required! Current kilometers: \(currentKilometers)"
        }

        // Tire and brake service (lower limit: 10000, upper limit: 15000)
        if currentKilometers >= 10000 && currentKilometers < 15000 {
            title = "Warning: Tire and brake service"
            content = "should be scheduled soon. Current kilometers: \(currentKilometers)"
        } else if currentKilometers >= 15000 {
            title = "Urgent: Tire and brake service"
            content = "is required! Current kilometers: \(currentKilometers)"
        }

        // Return the title and content if they are set
        if let title = title, let content = content {
            return (title, content)
        }
        return nil // Return nil if no conditions were met
    }

    
    func getLastUpdatedTime() -> Date {
            return lastUpdated
        }
    

}
