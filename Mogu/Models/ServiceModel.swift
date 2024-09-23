//
//  SummaryModel.swift
//  MoGu
//
//  Created by MacBook Air on 16/09/24.
//

import Foundation
import SwiftData

@Model
class ServiceModel {
    var serviceType: String
    var kilometersMin: String
    var kilometersMax: String
    var lastDateService: Date
    var maxDateService: Date
    var isServiceDataSet: Bool

    // Default initializer
    init(serviceType: String = "Unknown", kilometersMin: String = "", kilometersMax: String = "", lastDateService: Date = Date(), maxDateService: Date = Date(), isServiceDataSet: Bool = false) {
        self.serviceType = serviceType
        self.kilometersMax = kilometersMax
        self.kilometersMin = kilometersMin
        self.lastDateService = lastDateService
        self.maxDateService = maxDateService
        self.isServiceDataSet = isServiceDataSet
    }
}
