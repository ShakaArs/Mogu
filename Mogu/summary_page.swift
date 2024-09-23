import SwiftUI
import SwiftData

struct SummaryView: View {
    @ObservedObject var vehicleViewModel: VehicleViewModel
    @ObservedObject var serviceViewModel: ServiceViewModel
    @Query var vehicleModel: [VehicleModel]
    @Query var serviceModel: [ServiceModel]
    
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
                    
                    HStack{
                        Text("Components")
                            .padding(.leading)
                            .font(.title2)
                        Spacer()
                    }
                    
                    ForEach(serviceModel, id: \.self) { service in
                        switch service.serviceType {
                        case "Oil":
                            CardServiceFilled(
                                icon: "oilcan.fill",
                                buttonText: service.kilometersMin,
                                backgroundColor: .white,
                                serviceType: service.serviceType,
                                nextChange: service.maxDateService,
                                lastChange: service.maxDateService
                            )
                        case "Tire":
                            CardServiceFilled(
                                icon: "circle.circle.fill",
                                buttonText: service.kilometersMin,
                                backgroundColor: .white,
                                serviceType: service.serviceType,
                                nextChange: service.maxDateService,
                                lastChange: service.maxDateService
                            )
                        case "Brake":
                            CardServiceFilled(
                                icon: "pedal.brake.fill",
                                buttonText: service.kilometersMin,
                                backgroundColor: .white,
                                serviceType: service.serviceType,
                                nextChange: service.maxDateService,
                                lastChange: service.maxDateService
                            )
                        default:
                            EmptyView()
                        }
                    }
                    
                    servicePlaceholderView(serviceType: "Oil")
                    servicePlaceholderView(serviceType: "Tire")
                    servicePlaceholderView(serviceType: "Brake")

                    Spacer()
                }
                .navigationTitle("Summary")
                .navigationBarItems(trailing: NavigationLink(destination: HistoryView()) {
                    Image(systemName: "book.and.wrench")
                        .padding()
                        .foregroundColor(.green)
                        .font(.title2)
                })
            }
            .tabItem {
                Image(systemName: "engine.combustion.fill")
                Text("Summary")
            }
            
            NavigationView {
                ReminderView()
            }
            .tabItem {
                Image(systemName: "bell")
                Text("Reminder")
            }
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
        }
        return AnyView(EmptyView())
    }
}

#Preview {
    SummaryView(vehicleViewModel: VehicleViewModel(), serviceViewModel: ServiceViewModel())
}
