import SwiftUI

struct SummaryView: View {
    @ObservedObject var vehicleViewModel: VehicleViewModel
    @State private var path = NavigationPath()
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    // Top section: "Is it time to service?"
                    HStack {
                        Text("Is it")
                            .padding(.leading)
                            .font(.title2)
                        Text("Time")
                            .foregroundColor(.green)
                            .font(.title2)
                        Text("to service ?")
                            .font(.title2)
                        Spacer()
                    }
                    .padding(.top)

                    if vehicleViewModel.isVehicleDataSet {
                        DisplaySummaryKilometer(vehicleViewModel: vehicleViewModel)
                            .padding(.horizontal)

                    } else {
                        btnComponent(
                            icon: "",
                            iconInput: "chevron.right",
                            buttonText: "Set Your Vehicle",
                            backgroundColor: .green,
                            textColor: .white,
                            frameHeight: 60,
                            textSize: 25,
                            destination: InputVehiclePage(vehicleViewModel: vehicleViewModel) {
                            }
                        )
                    }

                    // Components section
                    HStack {
                        Text("Components")
                            .padding(.leading)
                            .font(.title2)
                        Spacer()
                    }
                    
                    // Buttons for setting component-related reminders
                    CardService(
                        icon: "oilcan.fill",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Latest Oil Change",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 95,
                        textSize: 15,
                        serviceType: "Oil"
                    )
                    
                    CardService(
                        icon: "circle.circle.fill",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Latest Tire Change",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 95,
                        textSize: 15,
                        serviceType: "Tire"
                    )
                    CardService(
                        icon: "pedal.brake.fill",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Latest Brake Change",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 95,
                        textSize: 15,
                        serviceType: "Brake"
                    )
                    
                    Spacer()
                }
                .navigationTitle("Summary")
                .navigationBarItems(trailing: NavigationLink(destination: HistoryView()) {
                    HStack {
                        Image(systemName: "book.and.wrench")
                            .padding()
                            .foregroundColor(.green)
                            .font(.title2)
                    }
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
}

#Preview {
    SummaryView(vehicleViewModel: VehicleViewModel())
}
