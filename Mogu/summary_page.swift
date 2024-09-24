import SwiftUI
import SwiftData
import UserNotifications

struct SummaryView: View {
    @ObservedObject var vehicleViewModel: VehicleViewModel
    @ObservedObject var serviceViewModel: ServiceViewModel
    @Query var vehicleModel: [VehicleModel]
    @Query var serviceModel: [ServiceModel]
    @State private var oil: Bool = false
    @State private var tire: Bool = false
    @State private var brake: Bool = false
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    
                    HStack {
                        Text("Is it")
                            .padding(.leading)
                            .font(.title2)
                        Text("Time")
                            .foregroundColor(.green)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("to service?")
                            .font(.title2)
                        Spacer()
                    }
                    .padding(.top)
                    
                    if !vehicleModel.isEmpty {
                        DisplaySummaryKilometer()
                            .padding(.horizontal)
                    } else {
                        noVehicleView
                    }
                    
                    HStack {
                        Text("Components")
                            .padding(.leading)
                            .font(.title2)
                        Spacer()
                    }
                    
                    ForEach(["Oil", "Tire", "Brake"], id: \.self) { serviceType in
                        if let mostRecentService = serviceModel
                            .filter({ $0.serviceType == serviceType })
                            .max(by: { $0.maxDateService < $1.maxDateService }) {
                            
                            CardServiceFilled(
                                icon: iconFor(serviceType),
                                buttonText: mostRecentService.kilometersMin,
                                backgroundColor: .white,
                                serviceType: mostRecentService.serviceType,
                                nextChange: mostRecentService.maxDateService,
                                lastChange: mostRecentService.maxDateService
                            )
                        } else {
                            servicePlaceholderView(serviceType: serviceType)
                        }
                    }
                    

                    Spacer()
                }
                .navigationTitle("Summary")
                .navigationBarItems(trailing: NavigationLink(destination: HistoryView()) {
                    Image(systemName: "book.and.wrench")
                        .padding()
                        .foregroundColor(.green)
                        .font(.title2)
                })
                .onAppear {
                    requestNotificationPermission()
                }
            }
            .tabItem {
                Image(systemName: "engine.combustion.fill")
                Text("Summary")
            }
            
            NavigationStack {
                ReminderView()
            }
            .tabItem {
                Image(systemName: "bell")
                Text("Reminder")
            }
        }
    }
    
    private func iconFor(_ serviceType: String) -> String {
        switch serviceType {
        case "Oil": return "oilcan.fill"
        case "Tire": return "circle.circle.fill"
        case "Brake": return "pedal.brake.fill"
        default: return "questionmark.circle"
        }
    }
    
    private var noVehicleView: some View {
        btnComponent(
            icon: "",
            iconInput: "chevron.right",
            buttonText: "Set Your Vehicle",
            backgroundColor: .green,
            textColor: .white,
            frameHeight: 60,
            textSize: 25,
            destination: InputVehiclePage(vehicleViewModel: vehicleViewModel) {}
        )
    }
    
    private func servicePlaceholderView(serviceType: String) -> some View {
        let isServiceFilled = serviceModel.contains(where: { $0.serviceType == serviceType })
        
        if !isServiceFilled {
            switch serviceType {
            case "Oil":
                return AnyView(CardService(
                    icon: "oilcan.fill",
                    iconInput: "chevron.right",
                    buttonText: "Set Your Latest Oil Change",
                    backgroundColor: .white,
                    textColor: .black,
                    frameHeight: 95,
                    textSize: 15,
                    serviceType: "Oil",
                    vehicleViewModel: vehicleViewModel.isVehicleDataSet
                ))
            case "Tire":
                return AnyView(CardService(
                    icon: "circle.circle.fill",
                    iconInput: "chevron.right",
                    buttonText: "Set Your Latest Tire Change",
                    backgroundColor: .white,
                    textColor: .black,
                    frameHeight: 95,
                    textSize: 15,
                    serviceType: "Tire",
                    vehicleViewModel: vehicleViewModel.isVehicleDataSet
                ))
            case "Brake":
                return AnyView(CardService(
                    icon: "pedal.brake.fill",
                    iconInput: "chevron.right",
                    buttonText: "Set Your Latest Brake Change",
                    backgroundColor: .white,
                    textColor: .black,
                    frameHeight: 95,
                    textSize: 15,
                    serviceType: "Brake",
                    vehicleViewModel: vehicleViewModel.isVehicleDataSet
                ))
            default:
                return AnyView(EmptyView())
            }
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        print("Notification permission granted.")
                    } else if let error = error {
                        print("Notification permission denied: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Notification permission already handled: \(settings.authorizationStatus.rawValue)")
            }
        }
    }
}

#Preview {
    SummaryView(vehicleViewModel: VehicleViewModel(), serviceViewModel: ServiceViewModel())
}
