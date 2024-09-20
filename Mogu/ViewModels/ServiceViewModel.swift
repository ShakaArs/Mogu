//
//  SeviceViewModel.swift
//  MoGu
//
//  Created by MacBook Air on 19/09/24.
//

import SwiftUI

class ServiceViewModel: ObservableObject{
    @Published var oilChangeDate: Date?
    @Published var tireChangeDate: Date?
    @Published var brakeChangeDate: Date?
    
    //Maximum Kilometer
    let maxKilometerForOil = 5000
    let maxKilometerForTire = 15000
    let maxKilometerForBrake = 15000
    
    //Lower kilometer thershold warning
    let oilWarningThreshold = 2500
    let tireWarningThreshold = 10000
    let brakeWarningThreshold = 10000
    
    func updateServiceDate(for serviceType: String, with date: Date) {
        switch serviceType {
            case "oil":
                oilChangeDate = date
            case "tire":
                tireChangeDate = date
            case "brake":
                brakeChangeDate = date
            default:
                break
        }
    }
    func checkServiceNeeds(for serviceType: String, currentKilometers: Int) -> String {
        switch serviceType {
            case "oil":
                return checkOilService(currentKilometers: currentKilometers)
            case "tire":
                return checkTireService(currentKilometers: currentKilometers)
            case "brake":
                return checkBrakeService(currentKilometers: currentKilometers)
            default:
                return "Unknown service type"
        }
    }
    private func checkOilService(currentKilometers: Int) -> String {
        if currentKilometers >= oilWarningThreshold && currentKilometers < maxKilometerForOil {
            return "Warning: Oil change should be scheduled soon. Current kilometers: \(currentKilometers)"
        } else if currentKilometers >= maxKilometerForOil {
            return "Urgent: Oil change required! Current kilometers: \(currentKilometers)"
        } else {
            return "Oil service not needed yet."
        }
    }
    
    private func checkTireService(currentKilometers: Int) -> String {
        if currentKilometers >= tireWarningThreshold && currentKilometers < maxKilometerForOil {
            return "Warning: Tire change should be scheduled soon. Current kilometers: \(currentKilometers)"
        } else if currentKilometers >= maxKilometerForTire {
            return "Urgent: Tire change required! Current kilometers: \(currentKilometers)"
        } else {
            return "Tire service not needed yet."
        }
    }
    
    private func checkBrakeService(currentKilometers: Int) -> String {
        if currentKilometers >= brakeWarningThreshold && currentKilometers < maxKilometerForBrake {
            return "Warning: Brake check should be scheduled soon. Current kilometers: \(currentKilometers)"
        } else if currentKilometers >= maxKilometerForBrake {
            return "Urgent: Brake check required! Current kilometers: \(currentKilometers)"
        } else {
            return "Brake service not needed yet."
        }
    }
    
}
