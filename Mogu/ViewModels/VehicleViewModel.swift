import Foundation

class VehicleViewModel: ObservableObject {
    // Properties that you want to store
    @Published var motorcyleType: String = "Unknown"
    @Published var kilometers: String = ""
    @Published var dailyUse: String = ""
    @Published var weeklyUse: String = ""
    @Published var isVehicleDataSet: Bool = false // New propertyr
    
    @Published var serviceViewModel = SeviceViewModel()

    // Method to create a new vehicle entry
    func createVehicle(motorcycleType: String, kilometers: String, dailyUse: String, weeklyUse: String) {
        self.motorcyleType = motorcycleType
        self.kilometers = kilometers
        self.dailyUse = dailyUse
        self.weeklyUse = weeklyUse
        self.isVehicleDataSet = true // Set to true after data is created
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
