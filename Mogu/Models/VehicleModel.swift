//
//  SummaryModel.swift
//  MoGu
//
//  Created by MacBook Air on 16/09/24.
//

import Foundation
import SwiftData

@Model
class VehicleModel {
    var motorcycleType: String
    var kilometers: String
    var dailyUse: String
    var weeklyUse: String
    var isVehicleDataSet: Bool
    var lastUpdated: Date

    // Default initializer
    init(motorcycleType: String = "Unknown", kilometers: String = "", dailyUse: String = "", weeklyUse: String = "", isVehicleDataSet: Bool = false, lastUpdated: Date = Date()) {
        self.motorcycleType = motorcycleType
        self.kilometers = kilometers
        self.dailyUse = dailyUse
        self.weeklyUse = weeklyUse
        self.isVehicleDataSet = isVehicleDataSet
        self.lastUpdated = lastUpdated
    }
}
