import Foundation

class VehicleViewModel: ObservableObject {
    // Properties that you want to store
    @Published var motorcyleType: String = "Unknown"
    @Published var kilometers: Int?
    @Published var dailyUse: Int?
    @Published var weeklyUse: Int?
    @Published var isVehicleDataSet: Bool = false // New property

    // Method to create a new vehicle entry
    func createVehicle(motorcycleType: String, kilometers: Int?, dailyUse: Int?, weeklyUse: Int?) {
        self.motorcyleType = motorcycleType
        self.kilometers = kilometers
        self.dailyUse = dailyUse
        self.weeklyUse = weeklyUse
        self.isVehicleDataSet = true // Set to true after data is created
    }

    // Method to reset the vehicle details (e.g., after saving or creating a new one)
    func resetVehicle() {
        self.motorcyleType = "Unknown"
        self.kilometers = nil
        self.dailyUse = nil
        self.weeklyUse = nil
        self.isVehicleDataSet = false
    }
}
