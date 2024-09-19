import Foundation

class VehicleViewModel: ObservableObject {
    // Properties that you want to store
    @Published var motorcyleType: String = "Unknown"
    @Published var kilometers: String = ""
    @Published var dailyUse: String = ""
    @Published var weeklyUse: String = ""
    @Published var isVehicleDataSet: Bool = false // New property

    // Method to create a new vehicle entry
    func createVehicle(motorcycleType: String, kilometers: String, dailyUse: String, weeklyUse: String) {
        self.motorcyleType = motorcycleType
        self.kilometers = kilometers
        self.dailyUse = dailyUse
        self.weeklyUse = weeklyUse
        self.isVehicleDataSet = true // Set to true after data is created
    }

    // Method to reset the vehicle details (e.g., after saving or creating a new one)
    func resetVehicle() {
        self.motorcyleType = "Unknown"
        self.kilometers = ""
        self.dailyUse = ""
        self.weeklyUse = ""
        self.isVehicleDataSet = false
    }
}
