import Foundation
import SwiftData


class VehicleViewModel: ObservableObject {
    // Properties that you want to store
    @Published var motorcycleType: String = "Unknown"
    @Published var kilometers: String = ""
    @Published var dailyUse: String = ""
    @Published var weeklyUse: String = ""
    @Published var isVehicleDataSet: Bool = false
    
    // Method to create a new vehicle entry
    func createVehicle(modelContext: ModelContext) {
        print(motorcycleType,kilometers,dailyUse,weeklyUse,isVehicleDataSet)
        let newVehicle = VehicleModel(
            motorcycleType: motorcycleType,
            kilometers: kilometers,
            dailyUse: dailyUse,
            weeklyUse: weeklyUse,
            isVehicleDataSet: true
        )
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
        }
    
    func updateInput(vehicle: VehicleModel, modelContext: ModelContext) {
            // Update the properties of the existing vehicle
//            vehicle.motorcycleType = motorcycleType
            vehicle.kilometers = kilometers
            vehicle.dailyUse = dailyUse
            vehicle.weeklyUse = weeklyUse
            
            do {
                try modelContext.save()  // Save the updated vehicle
                print("Vehicle updated successfully")
            } catch {
                print("Failed to update vehicle data: \(error.localizedDescription)")
            }
        }
    
    func updateKilometers() {
        let currentKilometers = Int(kilometers) ?? 0
        let dailyUsage = Int(dailyUse) ?? 0
        let weeklyUsage = Int(weeklyUse) ?? 0
                
        // Calculate the additional kilometers based on daily usage over a week
        let additionalKilometers = dailyUsage * weeklyUsage

        // Update the kilometers by adding the new usage
        let newKilometers = currentKilometers + additionalKilometers

        // Store the result back as a String
        self.kilometers = String(newKilometers)
                
        // Check service conditions for maintenance
        checkServiceConditions(currentKilometers: newKilometers)
    }
    // Check if service is needed based on kilometers
    private func checkServiceConditions(currentKilometers: Int) {
        // Oil service (lower limit: 2500, upper limit: 5000)
        if currentKilometers >= 2500 && currentKilometers < 5000 {
            print("Warning: Oil change recommended.")
        } else if currentKilometers >= 5000 {
            print("Urgent: Oil change required!")
        }
        // Tire and brake service (lower limit: 10000, upper limit: 15000)
        if currentKilometers >= 10000 && currentKilometers < 15000 {
            print("Warning: Tire and brake service recommended.")
        } else if currentKilometers >= 15000 {
            print("Urgent: Tire and brake service required!")
        }
    }
    
    
    

}
